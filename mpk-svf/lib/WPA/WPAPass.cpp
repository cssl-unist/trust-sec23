//===- WPAPass.cpp -- Whole program analysis pass------------------------------//
//
//                     SVF: Static Value-Flow Analysis
//
// Copyright (C) <2013-2017>  <Yulei Sui>
//

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//===-----------------------------------------------------------------------===//

/*
 * @file: WPA.cpp
 * @author: yesen
 * @date: 10/06/2014
 * @version: 1.0
 *
 * @section LICENSE
 *
 * @section DESCRIPTION
 *
 */


#include "Graphs/PTACallGraph.h"
#include "Graphs/SVFG.h"
#include "Graphs/SVFGNode.h"
#include "Util/BasicTypes.h"
#include "Util/Casting.h"
#include "Util/Options.h"
#include "Util/SVFBasicTypes.h"
#include "Util/SVFModule.h"
#include "MemoryModel/PointerAnalysisImpl.h"
#include "Util/SVFUtil.h"
#include "Util/WorkList.h"
#include "WPA/WPAPass.h"
#include "WPA/Andersen.h"
#include "WPA/AndersenSFR.h"
#include "WPA/FlowSensitive.h"
#include "WPA/FlowSensitiveTBHC.h"
#include "WPA/VersionedFlowSensitive.h"
#include "WPA/TypeAnalysis.h"
#include "WPA/Steensgaard.h"
#include "SVF-FE/PAGBuilder.h"
#include "RustIsolation/MPKRustIsolation.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include <utility>
#include "Util/DPItem.h"

using namespace SVF;
using namespace SVFUtil;

char WPAPass::ID = 0;


static llvm::RegisterPass<WPAPass> WHOLEPROGRAMPA("wpa",
        "Whole Program Pointer AnalysWPAis Pass");

map<Function*, std::vector<std::vector<const CallBlockNode*>>> RustAllocCallGraphs;
typedef std::map<const SVFGNode*, std::vector<const Value*>> SVFGNodeValueSetMap;
typedef std::map<const SVFGNode*, std::set<const SVFGNode*>> SVFGNodeNodeSetMap;
typedef std::set<const SVFGNode*> SVFGNodeSet;
typedef FILOWorkList<const SVFGNode*> SVFGNodeFIFOList;
typedef SVF::SVFGEdge::SVFGEdgeSetTy SVFGEdgeSet;
typedef std::vector<const Value*> ValueVec;
typedef std::map<const SVFGNode*,const SVFGNode*> SVFGNodeNodeMap;
typedef std::map<const SVFFunction*,SVFGNodeNodeSetMap> FunctionNodeNodeMap;
typedef std::vector<const SVFGNode*> NodePath;
typedef std::vector<NodePath> SVFGNodePathSet;
typedef std::map<const SVFGNode*, SVFGNodePathSet> SVFGNodePathSetMap;
typedef std::map<const SVFFunction*,SVFGNodePathSetMap> FunctionArgPathMap;
typedef std::set<NodePath> NodeStackSet;
typedef std::vector<const CallBlockNode*> CallStack;
typedef std::stack<const Function*> FunctionStack;
typedef set<CallBlockNode*> CallBlockNodeSet;
typedef map<CallBlockNode*, CallBlockNodeSet> CallBlockNodeNodeSetMap;
typedef map<const SVFGNode*, map<const CallBlockNode*, std::set<CallStack>>> PathTracker;
typedef CxtStmtDPItem<SVFGNode> DPIm;
typedef OrderedSet<DPIm> DPItemSet;

class MPKRustIsolation {
    typedef map<const SVFGNode*, set<CallStack>> SVFGNodeToCSSet;
private:
    map<const SVFGNode*, set<const SVFGNode*>> nodePathsMap;
    map<Function*, Function*> MpkRedefinedMap;
    map<CallBase*, Function*> CallBaseToCalleeMap;
    map<CallBase*,CallBase*> CallBase2NewCallBase;
    set<CallBase*> EntryReplaceCBNSet;
    map<CallBase*,set<int>> CallBaseArgBitMap;
    map<CallBase*,int> CallBaseToUnsafeBitMap;
    map<Function*,set<CallBase*>> FunctionToUnsafeCallBases;
    set<const SVFGNode*> visitedNodes;
    map<const SVFFunction*, map<const SVFGNode*, set<const SVFGNode*>>> Func2InOutsMap;
    NodeStackSet unsafePaths;
    set<CallBase*> unsafeCallBases;
    map<const CallBlockNode*, int> cbnArgBitMap;
    SVFGNodeSet unsafeNodes;
    map<const SVFGNode*, map<const CallBlockNode*, set<CallStack>>> nodeToCallStackMap;
    SVFG* svfg;
    PAG* pag;
    PointerAnalysis* _pta;
    PTACallGraph* callGraph;
    DPItemSet backwardVisited;
    DPItemSet finalAddrDpmSet;

    bool isbkVisited(const DPIm& dpm){
        return backwardVisited.find(dpm) != backwardVisited.end();
    }

    void markBackwardVisited(const DPIm& dpm){
        backwardVisited.insert(dpm);
    }

    void backTraceToStoreSrc(const DPIm& dpm, const StoreSVFGNode* store);

    void handleSingleStatement(const DPIm& dpm);

    const SVFModule* module;

    bool isEntryNode(const SVFGNode* node){
        return SVFUtil::isa<ActualParmSVFGNode>(node) || SVFUtil::isa<ActualINSVFGNode>(node);
    }

    bool isFormalEntryNode(const SVFGNode* node){
        return SVFUtil::isa<FormalINSVFGNode>(node) || SVFUtil::isa<FormalParmSVFGNode>(node);
    }

    bool isFormalExitNode(const SVFGNode* node){
        return SVFUtil::isa<FormalOUTSVFGNode>(node) || SVFUtil::isa<FormalOUTSVFGNode>(node);
    }

    bool isExitNode(const SVFGNode* node){
        return SVFUtil::isa<ActualRetSVFGNode>(node) || SVFUtil::isa<ActualOUTSVFGNode>(node);
    }

    bool isAllocNode(const SVFGNode* node){
        return SVFUtil::isa<AddrSVFGNode>(node);
    }

    const CallBlockNode* getCBN(const SVFGNode* node){
        const ActualOUTSVFGNode* aoNode = SVFUtil::dyn_cast<ActualOUTSVFGNode>(node);
        const ActualParmSVFGNode* apNode = SVFUtil::dyn_cast<ActualParmSVFGNode>(node);
        const ActualRetSVFGNode* arNode = SVFUtil::dyn_cast<ActualRetSVFGNode>(node);
        const ActualINSVFGNode* aiNode = SVFUtil::dyn_cast<ActualINSVFGNode>(node);

        const CallBlockNode* cbn = aoNode? aoNode->getCallSite():
                                   arNode? arNode->getCallSite():
                                   aiNode? aiNode->getCallSite():
                                   apNode? apNode->getCallSite(): nullptr;
        return cbn;
    }

    void popRecursiveCallSites(DPIm& dpm){
        ContextCond& cxtCond = dpm.getCond();
        cxtCond.setNonConcreteCxt();
        CallStrCxt& cxt = cxtCond.getContexts();
        while(!cxt.empty() && isEdgeInRecursion(cxt.back()))
        {
            cxt.pop_back();
        }
    }

    bool isEdgeInRecursion(CallSiteID csId)
    {
        const SVFFunction* caller = callGraph->getCallerOfCallSite(csId);
        const SVFFunction* callee = callGraph->getCalleeOfCallSite(csId);
        return _pta->inSameCallGraphSCC(caller, callee);
    }

    bool handleBKCondition(DPIm& dpm, const SVFGEdge* edge);

    void backwardPropDpm(NodeID ptr, const DPIm& oldDpm, const SVFGEdge* edge);

    void handleAddr(const DPIm& dpm, const AddrSVFGNode* addr);

    void backtraceAlongDirectVF(const DPIm& dpm);

    void backtraceAlongIndirectVF(const DPIm& dpm);

    void findPaths(const DPIm& dpm);

    CallSiteID getCSIDAtCall(DPIm&, const SVFGEdge* edge);
    CallSiteID getCSIDAtRet(DPIm&, const SVFGEdge* edge);
    bool isUnsafeVal(const Value* val);
    Function* redefineFunction(Function* func);
public:
    void computePaths(NodeID id);
    MPKRustIsolation(SVFG* _svfg, PAG* _pag, PointerAnalysis* pta): svfg(_svfg), pag(_pag), _pta(pta){
        ContextCond::maximumCxt = 10000000;
        ContextCond::setMaxCxtLen(100);
    }
    void dumpUnsafePaths();
    void finalRun();
};

void MPKRustIsolation::findPaths(const DPIm& dpm){
    if(isbkVisited(dpm)){
        return;
    }
    markBackwardVisited(dpm);
    handleSingleStatement(dpm);
}

bool MPKRustIsolation::isUnsafeVal(const Value* val){
    for(auto user: val->users()){
        if(const Instruction* inst = llvm::dyn_cast<Instruction>(user)){
            if(inst->getMetadata("MPK-Unsafe") != nullptr){
                return true;
            }
        }
    }

    return false;
}

CallSiteID MPKRustIsolation::getCSIDAtRet(DPIm&, const SVFGEdge* edge){

    CallSiteID svfg_csId = 0;
    if (const RetDirSVFGEdge* retEdge = SVFUtil::dyn_cast<RetDirSVFGEdge>(edge))
        svfg_csId = retEdge->getCallSiteId();
    else
        svfg_csId = SVFUtil::cast<RetIndSVFGEdge>(edge)->getCallSiteId();

    const CallBlockNode* cbn = svfg->getCallSite(svfg_csId);
    const SVFFunction* callee = edge->getSrcNode()->getFun();

    if(callGraph->hasCallSiteID(cbn,callee))
    {
        return callGraph->getCallSiteID(cbn,callee);
    }

    return 0;
}

CallSiteID MPKRustIsolation::getCSIDAtCall(DPIm&, const SVFGEdge* edge)
{

    CallSiteID svfg_csId = 0;
    if (const CallDirSVFGEdge* callEdge = SVFUtil::dyn_cast<CallDirSVFGEdge>(edge))
        svfg_csId = callEdge->getCallSiteId();
    else
        svfg_csId = SVFUtil::cast<CallIndSVFGEdge>(edge)->getCallSiteId();

    const CallBlockNode* cbn = svfg->getCallSite(svfg_csId);
    const SVFFunction* callee = edge->getDstNode()->getFun();

    if(callGraph->hasCallSiteID(cbn,callee))
    {
        return callGraph->getCallSiteID(cbn,callee);
    }

    return 0;
}

bool MPKRustIsolation::handleBKCondition(DPIm& dpm, const SVFGEdge* edge){
    if (edge->isCallVFGEdge())
    {
        /// we don't handle context in recursions, they treated as assignments
        if(CallSiteID csId = getCSIDAtCall(dpm,edge))
        {

            if(isEdgeInRecursion(csId))
            {
                popRecursiveCallSites(dpm);
            }
            else
            {
                if (dpm.matchContext(csId) == false)
                {
                    return false;
                }
            }
        }
    }

    else if (edge->isRetVFGEdge())
    {
        /// we don't handle context in recursions, they treated as assignments
        if(CallSiteID csId = getCSIDAtRet(dpm,edge))
        {

            if(isEdgeInRecursion(csId))
            {
                popRecursiveCallSites(dpm);
            }
            else
            {
                /// TODO: When this call site id is contained in current call string, we may find a recursion. Try
                ///       to solve this later.
                if (dpm.getCond().containCallStr(csId))
                {
                    return false;
                }
                else
                {
                    assert(dpm.getCond().containCallStr(csId) ==false && "contain visited call string ??");
                    dpm.pushContext(csId);
                }
            }
        }
    }

    return true;
}

void MPKRustIsolation::backwardPropDpm(NodeID ptr, const DPIm& oldDpm, const SVFGEdge* edge){
    DPIm dpm(oldDpm);
    dpm.setLocVar(edge->getSrcNode(), ptr);
    if(handleBKCondition(dpm, edge) == false){
        return;
    }
    findPaths(dpm);
}

void MPKRustIsolation::handleAddr(const DPIm& dpm, const AddrSVFGNode* addr){
    const Value* val = addr->getValue();
    if(val){
        if(llvm::isa<CallBase>(val)){
            finalAddrDpmSet.insert(dpm);
        }
    }
}

void MPKRustIsolation::backtraceAlongIndirectVF(const DPIm& oldDpm){
    const SVFGNode* node = oldDpm.getLoc();
    NodeID obj = oldDpm.getCurNodeID();
    const SVFGEdgeSet edgeSet(node->getInEdges());
    for(auto it = edgeSet.begin(), eit = edgeSet.end(); it != eit; ++it){
        if(const IndirectSVFGEdge* indirEdge = SVFUtil::dyn_cast<IndirectSVFGEdge>(*it)){
            backwardPropDpm(oldDpm.getCurNodeID(),oldDpm,indirEdge);
        }
    }
}

void MPKRustIsolation::backtraceAlongDirectVF(const DPIm& oldDpm){
    const SVFGNode* node = oldDpm.getLoc();
    NodeID obj = oldDpm.getCurNodeID();
    const SVFGEdgeSet edgeSet(node->getInEdges());
    for(auto it = edgeSet.begin(), eit = edgeSet.end(); it != eit; ++it){
        if(const DirectSVFGEdge* dirEdge = SVFUtil::dyn_cast<DirectSVFGEdge>(*it)){
            backwardPropDpm(oldDpm.getCurNodeID(),oldDpm,dirEdge);
        }
    }
}

void MPKRustIsolation::backTraceToStoreSrc(const DPIm& oldDpm, const StoreSVFGNode* store){
    if(!store->getPAGSrcNode()->isPointer())
        return;
    const SVFGNode* storeSrc = svfg->getDefSVFGNode(store->getPAGSrcNode());
    const SVFGEdge* edge = svfg->getIntraVFGEdge(storeSrc, store, SVFGEdge::IntraDirectVF);
    assert(edge && "Edge not found!");
    backwardPropDpm(store->getPAGSrcNodeID(),oldDpm,edge);
}

void MPKRustIsolation::handleSingleStatement(const DPIm& dpm){
    const SVFGNode* node = dpm.getLoc();
    errs()<<node->toString()<<"\n";
    if(SVFUtil::isa<AddrSVFGNode>(node)){
        handleAddr(dpm, SVFUtil::cast<AddrSVFGNode>(node));
    }
    else if(SVFUtil::isa<CopySVFGNode>(node) || SVFUtil::isa<PHISVFGNode>(node)
                    || SVFUtil::isa<ActualParmSVFGNode>(node) || SVFUtil::isa<FormalParmSVFGNode>(node)
                    || SVFUtil::isa<ActualRetSVFGNode>(node) || SVFUtil::isa<FormalRetSVFGNode>(node)
                    || SVFUtil::isa<NullPtrSVFGNode>(node) || SVFUtil::isa<ExtractValVFGNode>(node) 
                    || SVFUtil::isa<InsertValVFGNode>(node)){
        backtraceAlongDirectVF(dpm);
    }
    else if(SVFUtil::isa<LoadSVFGNode>(node)){
        backtraceAlongIndirectVF(dpm);
    }
    else if(const StoreSVFGNode* store = SVFUtil::dyn_cast<StoreSVFGNode>(node)){
        backTraceToStoreSrc(dpm,store);
    }
    else if(SVFUtil::isa<MRSVFGNode>(node)){
        backtraceAlongIndirectVF(dpm);
    }else{
        assert(false && "unknown node");
    }
}

void MPKRustIsolation::finalRun() {
}

Function* MPKRustIsolation::redefineFunction(Function *F) {
    std::vector<Type*> ArgTypes;
    llvm::ValueToValueMapTy VMap;
    // The user might be deleting arguments to the function by specifying them in
    // the VMap.  If so, we need to not add the arguments to the arg ty vector
    //

    for (const Argument &I : F->args())
        if (VMap.count(&I) == 0) // Haven't mapped the argument to anything yet?
            ArgTypes.push_back(I.getType());
    ArgTypes.push_back(Type::getInt8Ty(F->getContext()));
    // Create a new function type...
    FunctionType *FTy = FunctionType::get(F->getFunctionType()->getReturnType(),
                                          ArgTypes, F->getFunctionType()->isVarArg());

    // Create the new function...
    Function *NewF = Function::Create(FTy, F->getLinkage(), F->getAddressSpace(),
                                      "__mpk_unsafe"+F->getName().str(), F->getParent());

    if(F->isDeclaration())
        return NewF;
    // Loop over the arguments, copying the names of the mapped arguments over...
    Function::arg_iterator DestI = NewF->arg_begin();
    for (const Argument & I : F->args())
        if (VMap.count(&I) == 0) {     // Is this argument preserved?
            DestI->setName(I.getName()); // Copy the name over...
            VMap[&I] = &*DestI++;        // Add mapping to VMap
        }

    SmallVector<ReturnInst*, 8> Returns;  // Ignore returns cloned.
    CloneFunctionInto(NewF, F, VMap, F->getSubprogram() != nullptr, Returns, "",
                      nullptr);
    return NewF;
}

void MPKRustIsolation::dumpUnsafePaths() {
    for(auto p: unsafePaths){
        errs()<<"New Path\n";
        while(!p.empty()){
            errs()<<p.back()->toString()<<"\n";
            p.pop_back();
        }
    }
}

void MPKRustIsolation::computePaths(NodeID id){
    PAGNode* node = pag->getPAGNode(id);
    if(node->hasValue()){
        const PointsTo& pts = _pta->getPts(id);
        bool pointsToHeap = false;
        for(auto pt: pts){
            PAGNode* ptNode = pag->getPAGNode(pt);
            const MemObj *memObj = pag->getBaseObj(ptNode->getId());
            if(memObj->isHeap()){
                pointsToHeap = true;
                break;
            }
        }
        const Value* val = node->getValue();
        if(!(pointsToHeap && val && (llvm::isa<Instruction>(val) || llvm::isa<Argument>(val)) && isUnsafeVal(val))){
            return;
        }

        ContextCond cxt;
        CxtVar var(cxt, id);
        errs()<<node->toString()<<"\n";
        DPIm dpm(var, svfg->getDefSVFGNode(node));
        findPaths(dpm);
    }
}

void getCallPaths(const SVFModule* svfModule, const PTACallGraph* callgraph, const Function* f, std::vector<std::vector<const CallBlockNode*>>& paths, std::vector<const CallBlockNode*>& curPath) {
    if (const SVFFunction* sf = svfModule->getSVFFunction(f)) {
        PTACallGraphNode* cgn = callgraph->getCallGraphNode(sf);
        /* check if further path exists */
        if (cgn && cgn->hasIncomingEdge()) {
            /* incoming edges of this node */
            for (auto edgit = cgn->InEdgeBegin(); edgit != cgn->InEdgeEnd(); ++edgit) {
                PTACallGraphEdge* edg = *edgit;
                PTACallGraphEdge::CallInstSet cis = edg->getDirectCalls();
                for (const CallBlockNode* cbn : cis) {
                    const Function* cf = cbn->getCallSite()->getFunction();
                    curPath.push_back(cbn);
                    getCallPaths(svfModule, callgraph,cf, paths, curPath);
                    curPath.pop_back();
                }
            }
        }
        else {
            paths.push_back(curPath);
        }
    }
}


/*!
 * Destructor
 */
WPAPass::~WPAPass()
{
    PTAVector::const_iterator it = ptaVector.begin();
    PTAVector::const_iterator eit = ptaVector.end();
    for (; it != eit; ++it)
    {
        PointerAnalysis* pta = *it;
        delete pta;
    }
    ptaVector.clear();
}
bool isPtrUnsafe(const Value* v){
    if(const Instruction* inst = llvm::dyn_cast<Instruction>(v))
        return inst->getMetadata("MPK-Unsafe") != nullptr;
    
    for(auto user: v->users()){
        if(const Instruction* inst = llvm::dyn_cast<Instruction>(user)){
            if(inst->getMetadata("MPK-Unsafe") != nullptr)
                return true;
        }
    }

    return false;
}

const CallBase* usedInAllocEntryCall(const Value* val){
    for(const User* user: val->users()){
        if(const llvm::Instruction* Inst = llvm::dyn_cast<llvm::Instruction>(user))
            if(Inst->getMetadata("MPK-ALLOC-ENTRY") != nullptr)
                return llvm::dyn_cast<CallBase>(Inst);
    }

    return nullptr;
}

void WPAPass::findUnsafePointers(SVFG* svfg, PAG* pag, const SVFModule* svfModule){
    MPKRustIsolation* rustIsolation = new MPKRustIsolation(svfg, pag,_pta);

    vector<CallBase*> eraseSet;
    for(auto id: pag->getAllValidPtrs()){
        PAGNode* pagNode = pag->getPAGNode(id);
        if(pagNode->isTopLevelPtr()){
            if(pagNode->hasValue()){
                const Value* val = pagNode->getValue();
                if(val && isPtrUnsafe(val)){
                    auto pts = _pta->getPts(id);
                    for(auto pt: pts){
                        const MemObj* obj = pag->getBaseObj(pt);
                        if(obj->isStack()){
                            const Value* refVal = obj->getRefVal();
                            if(refVal){
                                AllocaInst*  AI = const_cast<AllocaInst*>(llvm::cast<AllocaInst>(obj->getRefVal()));
                                if(AI->getMetadata("MPK-Extern-Move") == nullptr){
                                    /// add metadata
                                    auto &cxt = AI->getContext();
                                    MDNode* N = MDNode::get(cxt, MDString::get(cxt, "Move unsafe object"));
                                    AI->setMetadata("MPK-Extern-Move", N);
                                }
                            }
                        }else if(obj->isHeap()){
                            // replace heap call
                            const Value* refVal = obj->getRefVal();
                            if(refVal){
                                const CallBase* allocCall = llvm::cast<CallBase>(obj->getRefVal());
                                Function* calledFunc = allocCall->getCalledFunction();
                                if(!calledFunc->getName().startswith("__mpk_unsafe")){
                                    //replace call with one to unsafe function.
                                    auto &cxt = allocCall->getContext();
                                    auto module = calledFunc->getParent();
                                    auto retTy = calledFunc->getReturnType();
                                    SmallVector<Type*,4> ArgTypes;
                                    for (const Argument &I : calledFunc->args())
                                        ArgTypes.push_back(I.getType());
                                    ArgTypes.push_back(Type::getInt8Ty(cxt));
                                    FunctionType* funcTy = FunctionType::get(retTy,ArgTypes,false);
                                    auto newName = "__mpk_unsafe"+calledFunc->getName().str();
                                    FunctionCallee func = module->getOrInsertFunction(newName,funcTy);
                                    llvm::IRBuilder<> IRB((Instruction*)allocCall);
                                    SmallVector<Value*,4> Args;
                                    for(auto& arg: allocCall->args()){
                                        Args.push_back(arg);
                                    }
                                    Value* flagArg = ConstantInt::get(Type::getInt8Ty(cxt),1);
                                    Args.push_back(flagArg);
                                    auto newCall = IRB.CreateCall(func,flagArg);
                                    auto alloc = const_cast<CallBase*>(allocCall);
                                    alloc->replaceAllUsesWith(newCall);
                                    eraseSet.push_back(alloc);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    while(!eraseSet.empty()){
        auto CB = eraseSet.back();
        eraseSet.pop_back();
        CB->eraseFromParent();
    }
}


void WPAPass::visitCallInst(CallInst *CI, PAG* pag) {
    using namespace llvm;
    for(Value* arg: CI->operands()){
        if (arg->getType()->isPointerTy()){
            const PointsTo &pts = _pta->getPts(pag->getValueNode(arg));
            for(unsigned int pt: pts){
                const MemObj* memObj = pag->getBaseObj(pt);
                if(memObj->isStack()){
                    AllocaInst* allocSite = llvm::dyn_cast<AllocaInst>(const_cast<Value*>(memObj->getRefVal()));
                    if(!allocSite->hasMetadata("MPK-Extern-Move")){
                        LLVMContext& C = allocSite->getContext();
                        MDNode* N = MDNode::get(C, MDString::get(C, "Alloca should move"));
                        allocSite->setMetadata("MPK-Extern-Move", N);
                    }
                }
            }
        }
    }
}

void removeDummyLoads(SVFModule* module){
    set<Instruction *> toRemove;
    for(auto it = module->begin(), eit = module->end(); it != eit; ++it){
        auto svfFunc = *it;
        for(auto &BB: *svfFunc->getLLVMFun()){
            for(auto &II: BB){
                if(II.getMetadata("MPK-Dummy-Load") != nullptr){
                    toRemove.insert(&II);
                }
            }
        }
    }

    for(auto inst: toRemove){
        inst->eraseFromParent();
    }
}

/*!
 * We start from here
 */
void WPAPass::runOnModule(SVFModule* svfModule)
{
    for (u32_t i = 0; i<= PointerAnalysis::Default_PTA; i++)
    {
        if (Options::PASelected.isSet(i))
            runPointerAnalysis(svfModule, i);
    }
    assert(!ptaVector.empty() && "No pointer analysis is specified.\n");

    PAG* pag = _pta->getPAG();
//    PTACallGraph* callGraph = _pta->getPTACallGraph();
//
//    ///Compute call graphs/paths of Rust (de)alloc functions, mark entry callsites
//    constructAllocFuncCallGraphs(svfModule,pag, callGraph);
//
//    ///Find and mark unsafe pointers, unsafe alloc entry calls
    findUnsafePointers(_svfg,pag,svfModule);

    removeDummyLoads(svfModule);

    LLVMModuleSet::getLLVMModuleSet()->dumpModulesToFile(".bc");
}

/*!
 * We start from here
 */
bool WPAPass::runOnModule(Module& module)
{
    SVFModule* svfModule = LLVMModuleSet::getLLVMModuleSet()->buildSVFModule(module);
    runOnModule(svfModule);
    return false;
}

/*!
 * Create pointer analysis according to a specified kind and then analyze the module.
 */
void WPAPass::runPointerAnalysis(SVFModule* svfModule, u32_t kind)
{
	/// Build PAG
	PAGBuilder builder;
	PAG* pag = builder.build(svfModule);
    /// Initialize pointer analysis.
    switch (kind)
    {
    case PointerAnalysis::Andersen_WPA:
        _pta = new Andersen(pag);
        break;
    case PointerAnalysis::AndersenLCD_WPA:
        _pta = new AndersenLCD(pag);
        break;
    case PointerAnalysis::AndersenHCD_WPA:
        _pta = new AndersenHCD(pag);
        break;
    case PointerAnalysis::AndersenHLCD_WPA:
        _pta = new AndersenHLCD(pag);
        break;
    case PointerAnalysis::AndersenSCD_WPA:
        _pta = new AndersenSCD(pag);
        break;
    case PointerAnalysis::AndersenSFR_WPA:
        _pta = new AndersenSFR(pag);
        break;
    case PointerAnalysis::AndersenWaveDiff_WPA:
        _pta = new AndersenWaveDiff(pag);
        break;
    case PointerAnalysis::AndersenWaveDiffWithType_WPA:
        _pta = new AndersenWaveDiffWithType(pag);
        break;
    case PointerAnalysis::Steensgaard_WPA:
        _pta = new Steensgaard(pag);
        break;
    case PointerAnalysis::FSSPARSE_WPA:
        _pta = new FlowSensitive(pag);
        break;
    case PointerAnalysis::FSTBHC_WPA:
        _pta = new FlowSensitiveTBHC(pag);
        break;
    case PointerAnalysis::VFS_WPA:
        _pta = new VersionedFlowSensitive(pag);
        break;
    case PointerAnalysis::TypeCPP_WPA:
        _pta = new TypeAnalysis(pag);
        break;
    default:
        assert(false && "This pointer analysis has not been implemented yet.\n");
        return;
    }

    ptaVector.push_back(_pta);
    _pta->analyze();
    if (Options::AnderSVFG)
    {
        SVFGBuilder memSSA(true);
        assert(SVFUtil::isa<AndersenBase>(_pta) && "supports only andersen/steensgaard for pre-computed SVFG");
        SVFG *svfg;
        if (Options::WPAOPTSVFG)
        {
            svfg = memSSA.buildFullSVFG((BVDataPTAImpl*)_pta);
        } else
        {
            svfg = memSSA.buildFullSVFGWithoutOPT((BVDataPTAImpl*)_pta);
        }

        /// support mod-ref queries only for -ander
        if (Options::PASelected.isSet(PointerAnalysis::AndersenWaveDiff_WPA))
            _svfg = svfg;
    }

    if (Options::PrintAliases)
        PrintAliasPairs(_pta);
}

void WPAPass::PrintAliasPairs(PointerAnalysis* pta)
{
    PAG* pag = pta->getPAG();
    for (PAG::iterator lit = pag->begin(), elit = pag->end(); lit != elit; ++lit)
    {
        PAGNode* node1 = lit->second;
        PAGNode* node2 = node1;
        for (PAG::iterator rit = lit, erit = pag->end(); rit != erit; ++rit)
        {
            node2 = rit->second;
            if(node1==node2)
                continue;
            const Function* fun1 = node1->getFunction();
            const Function* fun2 = node2->getFunction();
            AliasResult result = pta->alias(node1->getId(), node2->getId());
            SVFUtil::outs()	<< (result == AliasResult::NoAlias ? "NoAlias" : "MayAlias")
                            << " var" << node1->getId() << "[" << node1->getValueName()
                            << "@" << (fun1==nullptr?"":fun1->getName()) << "] --"
                            << " var" << node2->getId() << "[" << node2->getValueName()
                            << "@" << (fun2==nullptr?"":fun2->getName()) << "]\n";
        }
    }
}

/*!
 * Return alias results based on our points-to/alias analysis
 * TODO: Need to handle PartialAlias and MustAlias here.
 */
AliasResult WPAPass::alias(const Value* V1, const Value* V2)
{

    AliasResult result = llvm::MayAlias;

    PAG* pag = _pta->getPAG();

    /// TODO: When this method is invoked during compiler optimizations, the IR
    ///       used for pointer analysis may been changed, so some Values may not
    ///       find corresponding PAG node. In this case, we only check alias
    ///       between two Values if they both have PAG nodes. Otherwise, MayAlias
    ///       will be returned.
    if (pag->hasValueNode(V1) && pag->hasValueNode(V2))
    {
        /// Veto is used by default
        if (Options::AliasRule.getBits() == 0 || Options::AliasRule.isSet(Veto))
        {
            /// Return NoAlias if any PTA gives NoAlias result
            result = llvm::MayAlias;

            for (PTAVector::const_iterator it = ptaVector.begin(), eit = ptaVector.end();
                    it != eit; ++it)
            {
                if ((*it)->alias(V1, V2) == llvm::NoAlias)
                    result = llvm::NoAlias;
            }
        }
        else if (Options::AliasRule.isSet(Conservative))
        {
            /// Return MayAlias if any PTA gives MayAlias result
            result = llvm::NoAlias;

            for (PTAVector::const_iterator it = ptaVector.begin(), eit = ptaVector.end();
                    it != eit; ++it)
            {
                if ((*it)->alias(V1, V2) == llvm::MayAlias)
                    result = llvm::MayAlias;
            }
        }
    }

    return result;
}

/*!
 * Return mod-ref result of a CallInst
 */
ModRefInfo WPAPass::getModRefInfo(const CallInst* callInst)
{
    assert(Options::PASelected.isSet(PointerAnalysis::AndersenWaveDiff_WPA) && Options::AnderSVFG && "mod-ref query is only support with -ander and -svfg turned on");
    ICFG* icfg = _svfg->getPAG()->getICFG();
    const CallBlockNode* cbn = icfg->getCallBlockNode(callInst);
    return _svfg->getMSSA()->getMRGenerator()->getModRefInfo(cbn);
}

/*!
 * Return mod-ref results of a CallInst to a specific memory location
 */
ModRefInfo WPAPass::getModRefInfo(const CallInst* callInst, const Value* V)
{
    assert(Options::PASelected.isSet(PointerAnalysis::AndersenWaveDiff_WPA) && Options::AnderSVFG && "mod-ref query is only support with -ander and -svfg turned on");
    ICFG* icfg = _svfg->getPAG()->getICFG();
    const CallBlockNode* cbn = icfg->getCallBlockNode(callInst);
    return _svfg->getMSSA()->getMRGenerator()->getModRefInfo(cbn, V);
}

/*!
 * Return mod-ref result between two CallInsts
 */
ModRefInfo WPAPass::getModRefInfo(const CallInst* callInst1, const CallInst* callInst2)
{
    assert(Options::PASelected.isSet(PointerAnalysis::AndersenWaveDiff_WPA) && Options::AnderSVFG && "mod-ref query is only support with -ander and -svfg turned on");
    ICFG* icfg = _svfg->getPAG()->getICFG();
    const CallBlockNode* cbn1 = icfg->getCallBlockNode(callInst1);
    const CallBlockNode* cbn2 = icfg->getCallBlockNode(callInst2);
    return _svfg->getMSSA()->getMRGenerator()->getModRefInfo(cbn1, cbn2);
}
