/*
 * @file: DDAPass.cpp
 * @author: Yulei Sui
 * @date: 01/07/2014
 */


#include "Util/DPItem.h"
#include "Util/Options.h"
#include "MemoryModel/PointerAnalysisImpl.h"
#include "DDA/DDAPass.h"
#include "DDA/FlowDDA.h"
#include "DDA/ContextDDA.h"
#include "DDA/DDAClient.h"
#include "SVF-FE/PAGBuilder.h"
#include "RustIsolation/MPKRustIsolation.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include <sstream>
#include <limits.h>
#include <utility>

using namespace SVF;
using namespace SVFUtil;
map<Function*, set<const CallBlockNode*>> RustAllocCallGraphs;
map<CallBase*,Function*> CallBaseToCalleeMap;
map<Function*,Function*> MpkRedefinedMap;
map<CallBase*,CallBase*> CallBase2NewCallBase;
map<CallBase*,set<int>> CallBaseToUnsafeBitsArgs;
set<CallBase*>UnsafeCallBases;
map<Function*,set<CallBase*>> FunctionToUnsafeCallBasesMap;
map<CallBase*,int> CallBaseToUnsafeBitMap;
set<CallBase*> EntryReplaceCBNSet;
map<CallBase*,set<Function*>> IndirectCallsToVirtualFunctionMap;

set<const SVFGNode*> UnsafePointers;
map<Function*,AllocaInst*> IndirectFuncToUnsafeSpaceMap;
map<CallBase*,CallBase*> IndirectCBMap;
set<Function*> IndirectlyDefined;

typedef std::map<const SVFGNode*, std::vector<const Value*>> SVFGNodeValueSetMap;
typedef std::map<const SVFGNode*, std::set<const SVFGNode*>> SVFGNodeNodeSetMap;
typedef std::set<const SVFGNode*> SVFGNodeSet;
typedef FILOWorkList<const SVFGNode*> SVFGNodeFIFOList;
typedef SVF::SVFGEdge::SVFGEdgeSetTy SVFGEdgeSet;
typedef std::vector<const Value*> ValueVec;
typedef std::map<const SVFGNode*,const SVFGNode*> SVFGNodeNodeMap;
typedef std::map<const SVFFunction*,SVFGNodeNodeSetMap> FunctionNodeNodeMap;
typedef std::vector<const SVFGNode*> SVFGNodePath;
typedef std::vector<SVFGNodePath> SVFGNodePathSet;
typedef std::map<const SVFGNode*, SVFGNodePathSet> SVFGNodePathSetMap;
typedef std::map<const SVFFunction*,SVFGNodePathSetMap> FunctionArgPathMap;
typedef std::stack<const Value*> ValueStack;
typedef std::stack<const CallBlockNode*> CallStack;
typedef set<CallBlockNode*> CallBlockNodeSet;
typedef map<CallBlockNode*, CallBlockNodeSet> CallBlockNodeNodeSetMap;

map<const SVFGNode*, bool> ForwardVisitedNodes;

static bool isForwardVisited(const SVFGNode* node){
    return ForwardVisitedNodes.find(node) != ForwardVisitedNodes.end();
}

static bool isUnsafePathNode(const SVFGNode* node){
    assert(isForwardVisited(node) && "testing unvisited node?");
    return ForwardVisitedNodes.find(node)->second;
}

static void markForwardVisitedNode(const SVFGNode* node){
    ForwardVisitedNodes.insert(make_pair(node, false));
}

static void updateVisitedNode(const SVFGNode* node, bool unsafety){
    ForwardVisitedNodes.insert(make_pair(node, unsafety));
}

static bool recursiveTraverseUnsafety(const SVFGNode* node, const ContextCond& cxt){
    if(isForwardVisited(node))
        return isUnsafePathNode(node);
    markForwardVisitedNode(node);
    return false;
}

static bool isPtrUnsafe(const Value* v){
    for(const User* user: v->users()){
        if(const llvm::Instruction* Inst = llvm::dyn_cast<llvm::Instruction>(user))
            if(Inst->getMetadata("MPK-Unsafe") != nullptr)
                return true;
    }

    return false;
}

static uint64_t unsafePointerCount = 0;
static void traverseUnsafePointerCopies(SVFG* _svfg, PAG* pag){ 
    FIFOWorkList<const SVFGNode *> workList;
    SVFGNodeSet visited;
    for(auto node: UnsafePointers) {
        workList.push(node);
        bool foundUnsafe = false;
        while (!workList.empty()) {
            unsafePointerCount++;
            const SVFGNode *currNode = workList.pop();
            if (const GepSVFGNode* gepNode = SVFUtil::dyn_cast<GepSVFGNode>(currNode)) {
                auto nodeVal = gepNode->getValue();
                Instruction* inst = const_cast<Instruction*>(llvm::cast<Instruction>(nodeVal));
                auto &cxt = inst->getContext();
                MDNode* N = MDNode::get(cxt,MDString::get(cxt,"SFI-GEP-WRAP"));
                inst->setMetadata("POSSIBLE-Unsafe",N);
            }
            SVFGEdgeSet outEdges(currNode->getOutEdges());
            for (auto it = outEdges.begin(), eit = outEdges.end(); it != eit; ++it) {
                SVFGEdge *edge = *it;
                if (const DirectSVFGEdge *dirEdge = SVFUtil::dyn_cast<DirectSVFGEdge>(edge)) {
                    const SVFGNode *dest = dirEdge->getDstNode();
                    if (SVFUtil::isa<CopySVFGNode>(dest) || SVFUtil::isa<ActualParmSVFGNode>(dest) ||
                        SVFUtil::isa<FormalParmSVFGNode>(dest) || SVFUtil::isa<FormalRetSVFGNode>(dest) ||
                        SVFUtil::isa<ActualRetSVFGNode>(dest) || SVFUtil::isa<GepSVFGNode>(dest) || SVFUtil::isa<LoadSVFGNode>(dest)) {
                        if(visited.find(dest) == visited.end()) {
                            workList.push(dest);
                            visited.insert(dest);
                        }
                    }
                }
            }
        }
    }
}



void getCallPaths(const SVFModule* svfModule, const PTACallGraph* callgraph, const Function* f, set<const CallBlockNode*>& curPath) {
    if (const SVFFunction* sf = svfModule->getSVFFunction(f)) {
        PTACallGraphNode* cgn = callgraph->getCallGraphNode(sf);
        /* check if further path exists */
        if (cgn && cgn->hasIncomingEdge()) {
            /* incoming edges of this node */
            for (auto edgit = cgn->InEdgeBegin(); edgit != cgn->InEdgeEnd(); ++edgit) {
                PTACallGraphEdge* edg = *edgit;
                PTACallGraphEdge::CallInstSet cis = edg->getDirectCalls();
                for (const CallBlockNode* cbn : cis) {
                    curPath.insert(cbn);
                }
            }
        }
    }
}


char DDAPass::ID = 0;

static llvm::RegisterPass<DDAPass> DDAPA("dda", "Demand-driven Pointer Analysis Pass");

DDAPass::~DDAPass()
{
    // _pta->dumpStat();
    if (_client != nullptr)
        delete _client;
}

Function* redefineFunction(Function*  F){
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

void mapFunctionCallBases(Function* oldFunc, Function* newFunc){
    if(oldFunc->isDeclaration())
        return;

    for(auto BB = oldFunc->begin(), newBB = newFunc->begin(), BE = oldFunc->end(), newBE = newFunc->end(); BB != BE; ++BB, ++newBB){
        if(newBB == newBE){
            assert(BB == BE && "both functions must end together");
        }

        for(auto II = BB->begin(), newII = newBB->begin(), IE = BB->end(), newIE = newBB->end(); II != IE; ++II, ++newII){
            if(newII == newIE){
                assert(II == IE && "both functions must end together");
            }

            if(CallBase* CB = llvm::dyn_cast<CallBase>(II)){
                CallBase2NewCallBase.insert(make_pair(llvm::cast<CallBase>(newII),CB));
                if(IndirectCallsToVirtualFunctionMap.find(CB) != IndirectCallsToVirtualFunctionMap.end()) {
                    IndirectCBMap.insert(make_pair(CB,llvm::cast<CallBase>(newII)));
                }
            }
        }
    }
}

void organizeCallBlocks(){
    for(auto callBase: UnsafeCallBases){
        auto funIt = CallBaseToCalleeMap.find(callBase);
        if(funIt != CallBaseToCalleeMap.end()){
            Function* calledFunc = funIt->second;
            if(MpkRedefinedMap.find(calledFunc) == MpkRedefinedMap.end()){
                Function* redefined = redefineFunction(calledFunc);
                MpkRedefinedMap.insert(make_pair(calledFunc, redefined));
            }
        }
    }

    for(auto ff: MpkRedefinedMap){
        mapFunctionCallBases(ff.first, ff.second);
    }


    for(auto it: IndirectCallsToVirtualFunctionMap) {
        auto funcs = it.second;
        for (auto func: funcs) {
            if(!func->isDeclaration() && IndirectFuncToUnsafeSpaceMap.find(func) == IndirectFuncToUnsafeSpaceMap.end()){
                IRBuilder IRB(&(*func->begin()->begin()));
                auto &cxt = func->getContext();
                Type* i8Type = Type::getInt8Ty(cxt);
                AllocaInst* unsafeSpace = IRB.CreateAlloca(Type::getInt8Ty(cxt));
                IndirectFuncToUnsafeSpaceMap.insert(make_pair(func,unsafeSpace));
                std::vector<Type *> arg_type;
                std::vector<Value*> args;
                MDNode *N = MDNode::get(cxt, {MDString::get(cxt, "r15")});
                arg_type.push_back(Type::getInt64Ty(cxt));
                Function *readRegisterFunc = llvm::Intrinsic::getDeclaration(func->getParent(), llvm::Intrinsic::read_register, arg_type);
                args.push_back(MetadataAsValue::get(cxt,N));
                Value* savedStackPtr = IRB.CreateCall(readRegisterFunc, args);
                Type* int8PtrTy = Type::getInt8PtrTy(cxt);
                Value* intToPtr = IRB.CreateIntToPtr(savedStackPtr,int8PtrTy);
                auto unsafeFlagGep = IRB.CreateGEP(intToPtr,ConstantInt::get(i8Type,32));
                auto unsafeArg = IRB.CreateLoad(unsafeFlagGep);
                IRB.CreateStore(unsafeArg,unsafeSpace);
            }
        }
    }
}

bool replaceUnsafeCalls(){
    organizeCallBlocks();
    std::vector<CallBase *> oldCalls;
    for(auto ff: MpkRedefinedMap){
        Function* origFunc = ff.first;
        Function* redefined = ff.second;

        for(auto use = origFunc->user_begin(), use_end = origFunc->user_end(); use != use_end; ++use){
            if(CallBase* unsafeCall = llvm::dyn_cast<CallBase>(*use)){
                bool isEntry = EntryReplaceCBNSet.find(unsafeCall) != EntryReplaceCBNSet.end();
                Function* parentFunc = unsafeCall->getFunction();
                bool isInIndirect = IndirectFuncToUnsafeSpaceMap.find(parentFunc) != IndirectFuncToUnsafeSpaceMap.end();
                set<int> UnsafeArgBits;
                int callBaseUnsafeBit = -1;
                if(isEntry) {
                    UnsafeArgBits = CallBaseToUnsafeBitsArgs[unsafeCall];
                }else if(parentFunc->getName().startswith("__mpk_unsafe")){
                    CallBase* origCB = CallBase2NewCallBase[unsafeCall];
                    UnsafeArgBits = CallBaseToUnsafeBitsArgs[origCB];
                    callBaseUnsafeBit = CallBaseToUnsafeBitMap[origCB];
                }else if(!isInIndirect){
                    continue;
                }

                Type* i8Type = IntegerType::getInt8Ty(unsafeCall->getContext());
                Constant* i8Val = ConstantInt::get(i8Type,1, false);
                Value* unsafeArg = nullptr;
                IRBuilder IRB(unsafeCall);
                int unsafeArgValue = 0;
                for(auto bit: UnsafeArgBits){
                    unsafeArgValue |= (1 << bit);
                }

                if(isEntry){
                    unsafeArg = ConstantInt::get(i8Type,unsafeArgValue);
                }else{
                    int andValue = 1 << callBaseUnsafeBit;
                    Constant* unsafeAnd = ConstantInt::get(i8Type, andValue,false);
                    Value* unsafeArgBitVal = nullptr;
                    if(isInIndirect){
                        auto allocaSpace = IndirectFuncToUnsafeSpaceMap.find(parentFunc)->second;
                        unsafeArgBitVal = IRB.CreateLoad(allocaSpace);
                    }else {
                        assert(parentFunc->getName().startswith("__mpk_unsafe") &&
                               "this must be done in an unsafe function");
                        unsafeArgBitVal = parentFunc->getArg(parentFunc->arg_size() - 1);
                    }
                    unsafeArg = IRB.CreateAnd(unsafeAnd,unsafeArgBitVal);
                    Constant* zeroVal = ConstantInt::get(i8Type,0, false);
                    Value* cmp = IRB.CreateCmp(llvm::CmpInst::Predicate::ICMP_NE,unsafeArg,zeroVal);
                    unsafeArg = ConstantInt::get(i8Type, unsafeArgValue);
                    unsafeArg = IRB.CreateSelect(cmp,unsafeArg,zeroVal);
                }

                std::vector<Value*> Args;
                Args.insert(Args.begin(),unsafeCall->arg_begin(), unsafeCall->arg_end());
                Args.push_back(unsafeArg);

                llvm::AttributeList PAL = unsafeCall->getAttributes();
                if(!PAL.isEmpty()){
                    llvm::SmallVector<llvm::AttributeSet,8> ArgAttrs;
                    for(unsigned ArgNo = 0; ArgNo < unsafeCall->getNumArgOperands(); ++ArgNo)
                        ArgAttrs.push_back(PAL.getParamAttributes(ArgNo));
                    PAL = llvm::AttributeList::get(origFunc->getContext(), PAL.getFnAttributes(),PAL.getRetAttributes(), ArgAttrs);
                }

                SmallVector<llvm::OperandBundleDef, 1> OpBundles;
                unsafeCall->getOperandBundlesAsDefs(OpBundles);

                CallBase *NewCB = nullptr;
                if(InvokeInst* II = llvm::dyn_cast<InvokeInst>(unsafeCall)){
                    NewCB = InvokeInst::Create(redefined, II->getNormalDest(), II->getUnwindDest(), Args, OpBundles, "", unsafeCall);
                }else{
                    NewCB = CallInst::Create(redefined, Args, OpBundles, "", unsafeCall);
                    llvm::cast<CallInst>(NewCB)->setTailCallKind(llvm::cast<CallInst>(unsafeCall)->getTailCallKind());
                }
                NewCB->setCallingConv(unsafeCall->getCallingConv());
                NewCB->setAttributes(PAL);
                NewCB->copyMetadata(*unsafeCall,{LLVMContext::MD_prof, LLVMContext::MD_dbg});
                if(!unsafeCall->use_empty())
                    unsafeCall->replaceAllUsesWith(NewCB);
                oldCalls.push_back(unsafeCall);
            }
        }
    }

    /*
    for(auto unsafeCall: UnsafeCallBases){
        bool isEntry = EntryReplaceCBNSet.find(unsafeCall) != EntryReplaceCBNSet.end();
        CallBase* toReplace = isEntry ? unsafeCall: CallBase2NewCallBase.find(unsafeCall)->second;
        std::vector<Value*> Args;
        set<int> UnsafeArgBits = CallBaseToUnsafeBitsArgs[unsafeCall];
        int callBaseUnsafeBit = isEntry? -1: CallBaseToUnsafeBitMap[unsafeCall];

        Type* i8Type = IntegerType::getInt8Ty(toReplace->getContext());
        Constant* i8Val = ConstantInt::get(i8Type,1, false);
        Value* unsafeArg = nullptr;
        IRBuilder IRB(toReplace);
        int unsafeArgValue = 0;
        for(auto bit: UnsafeArgBits){
            unsafeArgValue |= (1 << bit);
        }
        
        if(isEntry){
            unsafeArg = ConstantInt::get(i8Type,unsafeArgValue);
        }else{
            Function* parentFunc = toReplace->getFunction();
            int andValue = 1 << callBaseUnsafeBit;
            Constant* unsafeAnd = ConstantInt::get(i8Type, andValue,false);
            Value* unsafeArgBitVal = nullptr;
            if(!parentFunc->getName().startswith("__mpk_unsafe")){
                auto indIt = IndirectFuncToUnsafeSpaceMap.find(parentFunc);
                assert(indIt != IndirectFuncToUnsafeSpaceMap.end() && "can't resolve callbase arg bit value?");
                auto unsafeArgSpace = indIt->second;
                unsafeArgBitVal = IRB.CreateLoad(unsafeArgSpace);
            }else{
                unsafeArgBitVal = parentFunc->getArg(parentFunc->arg_size()-1);
            }
            
            unsafeArg = IRB.CreateAnd(unsafeAnd,unsafeArgBitVal);
            Constant* zeroVal = ConstantInt::get(i8Type,0, false);
            Value* cmp = IRB.CreateCmp(llvm::CmpInst::Predicate::ICMP_NE,unsafeArg,zeroVal);
            unsafeArg = ConstantInt::get(i8Type, unsafeArgValue);
            unsafeArg = IRB.CreateSelect(cmp,unsafeArg,zeroVal);

        }
        
        assert(unsafeArg != nullptr && "did not build unsafe argument?");

        auto funIt = CallBaseToCalleeMap.find(unsafeCall);
        if(funIt == CallBaseToCalleeMap.end()){
            Function* parentFunc = unsafeCall->getFunction();
            std::vector<Type *> arg_type;
            std::vector<Value*> args;
            LLVMContext &C = parentFunc->getContext();
            MDNode *N = MDNode::get(C, {MDString::get(C, "r15")});
            arg_type.push_back(Type::getInt64Ty(C));
            Function *readRegisterFunc = llvm::Intrinsic::getDeclaration(parentFunc->getParent(), llvm::Intrinsic::read_register, arg_type);
            args.push_back(MetadataAsValue::get(C,N));

            Value* savedStackPtr = IRB.CreateCall(readRegisterFunc, args);
            Type* int8PtrTy = Type::getInt8PtrTy(C);
            Value* intToPtr = IRB.CreateIntToPtr(savedStackPtr,int8PtrTy);
            auto unsafeFlagGep = IRB.CreateGEP(intToPtr,ConstantInt::get(i8Type,32));
            IRB.CreateStore(unsafeArg,unsafeFlagGep);
            continue;
        }
        Function* origFunc = funIt->second;
        Function* redefined = MpkRedefinedMap.find(origFunc)->second;
        
        Args.insert(Args.begin(),toReplace->arg_begin(), toReplace->arg_end());
        Args.push_back(unsafeArg);

        llvm::AttributeList PAL = toReplace->getAttributes();
        if(!PAL.isEmpty()){
            llvm::SmallVector<llvm::AttributeSet,8> ArgAttrs;
            for(unsigned ArgNo = 0; ArgNo < toReplace->getNumArgOperands(); ++ArgNo)
                ArgAttrs.push_back(PAL.getParamAttributes(ArgNo));
            PAL = llvm::AttributeList::get(origFunc->getContext(), PAL.getFnAttributes(),PAL.getRetAttributes(), ArgAttrs);
        }

        SmallVector<llvm::OperandBundleDef, 1> OpBundles;
        toReplace->getOperandBundlesAsDefs(OpBundles);

        CallBase *NewCB = nullptr;
        if(InvokeInst* II = llvm::dyn_cast<InvokeInst>(toReplace)){
            NewCB = InvokeInst::Create(redefined, II->getNormalDest(), II->getUnwindDest(), Args, OpBundles, "", toReplace);
        }else{
            NewCB = CallInst::Create(redefined, Args, OpBundles, "", toReplace);
            llvm::cast<CallInst>(NewCB)->setTailCallKind(llvm::cast<CallInst>(toReplace)->getTailCallKind());
        }
        NewCB->setCallingConv(toReplace->getCallingConv());
        NewCB->setAttributes(PAL);
        NewCB->copyMetadata(*toReplace,{LLVMContext::MD_prof, LLVMContext::MD_dbg});
        if(!toReplace->use_empty())
            toReplace->replaceAllUsesWith(NewCB);
        oldCalls.push_back(toReplace);
    }
     */

    for(auto it: IndirectCallsToVirtualFunctionMap){
        auto unsafeCall = it.first;
        bool isEntry = EntryReplaceCBNSet.find(unsafeCall) != EntryReplaceCBNSet.end();
        CallBase * replacement = isEntry? unsafeCall: IndirectCBMap.find(unsafeCall)->second;
        Function* parentFunc = replacement->getFunction();
        bool isInIndirect = IndirectFuncToUnsafeSpaceMap.find(parentFunc) != IndirectFuncToUnsafeSpaceMap.end();
        set<int> UnsafeArgBits;
        int callBaseUnsafeBit = -1;
        if(isEntry) {
            UnsafeArgBits = CallBaseToUnsafeBitsArgs[unsafeCall];
        }else if(parentFunc->getName().startswith("__mpk_unsafe")){
            CallBase* origCB = CallBase2NewCallBase[unsafeCall];
            UnsafeArgBits = CallBaseToUnsafeBitsArgs[origCB];
            callBaseUnsafeBit = CallBaseToUnsafeBitMap[origCB];
        }else if(!isInIndirect) {
            continue;
        }

        Type* i8Type = IntegerType::getInt8Ty(unsafeCall->getContext());
        Constant* i8Val = ConstantInt::get(i8Type,1, false);
        Value* unsafeArg = nullptr;
        IRBuilder IRB(replacement);
        int unsafeArgValue = 0;
        for(auto bit: UnsafeArgBits){
            unsafeArgValue |= (1 << bit);
        }

        if(isEntry){
            unsafeArg = ConstantInt::get(i8Type,unsafeArgValue);
        }else{
            int andValue = 1 << callBaseUnsafeBit;
            Constant* unsafeAnd = ConstantInt::get(i8Type, andValue,false);
            Value* unsafeArgBitVal = nullptr;
            if(isInIndirect){
                auto allocaSpace = IndirectFuncToUnsafeSpaceMap.find(parentFunc)->second;
                unsafeArgBitVal = IRB.CreateLoad(allocaSpace);
            }else {
                assert(parentFunc->getName().startswith("__mpk_unsafe") &&
                       "this must be done in an unsafe function");
                unsafeArgBitVal = parentFunc->getArg(parentFunc->arg_size() - 1);
            }
            unsafeArg = IRB.CreateAnd(unsafeAnd,unsafeArgBitVal);
            Constant* zeroVal = ConstantInt::get(i8Type,0, false);
            Value* cmp = IRB.CreateCmp(llvm::CmpInst::Predicate::ICMP_NE,unsafeArg,zeroVal);
            unsafeArg = ConstantInt::get(i8Type, unsafeArgValue);
            unsafeArg = IRB.CreateSelect(cmp,unsafeArg,zeroVal);
        }
        IRB.SetInsertPoint(replacement);
        std::vector<Type *> arg_type;
        std::vector<Value*> args;
        LLVMContext &C = parentFunc->getContext();
        MDNode *N = MDNode::get(C, {MDString::get(C, "r15")});
        arg_type.push_back(Type::getInt64Ty(C));
        Function *readRegisterFunc = llvm::Intrinsic::getDeclaration(parentFunc->getParent(), llvm::Intrinsic::read_register, arg_type);
        args.push_back(MetadataAsValue::get(C,N));

        Value* savedStackPtr = IRB.CreateCall(readRegisterFunc, args);
        Type* int8PtrTy = Type::getInt8PtrTy(C);
        Value* intToPtr = IRB.CreateIntToPtr(savedStackPtr,int8PtrTy);
        auto unsafeFlagGep = IRB.CreateGEP(intToPtr,ConstantInt::get(i8Type,32));
        IRB.CreateStore(unsafeArg,unsafeFlagGep);
    }

    while(!oldCalls.empty()){
        CallBase *CB = oldCalls.back();
        oldCalls.pop_back();
        CB->eraseFromParent();
    }

    return true;
}

void removeDummyLoads(SVFModule* module){
    set<Instruction*> toRemove;
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


void DDAPass::findUnsafePointers(PointerAnalysis* pta, SVFG* svfg, PAG* pag, const SVFModule* svfModule){
    
    const set<CxtLocDPItem> heapPaths = ((ContextDDA*)_pta)->getFinalHeapDpms(); 
    for(auto dpm: heapPaths){
        ContextCond cxt = dpm.getCond();
        CallStrCxt calls = cxt.getContexts();
        if(!calls.empty()){

            for(auto call: calls){
                const CallBlockNode* cbn = _pta->getPTACallGraph()->getCallSite(call);
            }
            
            const CallBlockNode* cbn = _pta->getPTACallGraph()->getCallSite(calls.front());
            Function* topCaller = cbn->getCaller()->getLLVMFun();
            if(!isRustLibraryFunc(topCaller)){
                const SVFGNode* node = dpm.getLoc();
                const Value* nodeVal = node->getValue();
                assert(llvm::isa<CallBase>(nodeVal) && "added a non-call node as final?");
                CallBase* allocCallBase = const_cast<CallBase*>(llvm::cast<CallBase>(nodeVal));
                if(allocCallBase->getCalledFunction()->getName().startswith("__mpk_unsafe")){
                    continue;
                }
                UnsafeCallBases.insert(allocCallBase);
                Function* calledFunc = allocCallBase->getCalledFunction();
                CallBaseToCalleeMap.insert(make_pair(allocCallBase,calledFunc));
                if(MpkRedefinedMap.find(calledFunc) == MpkRedefinedMap.end()){
                    ///define unsafe alloc func
                    Function* redefined = redefineFunction(calledFunc);
                    MpkRedefinedMap.insert(make_pair(calledFunc, redefined));
                    LLVMContext &C = allocCallBase->getContext();
                    MDNode *N = MDNode::get(C, MDString::get(C, "Unsafe call replacement"));
                    allocCallBase->setMetadata("MPK-HEAP-MOVE", N);
                }
                {
                    Function* allocCaller = allocCallBase->getCalledFunction();
                    if(FunctionToUnsafeCallBasesMap.find(allocCaller) == FunctionToUnsafeCallBasesMap.end()){
                        set<CallBase*> ts;
                        ts.insert(allocCallBase);
                        CallBaseToUnsafeBitMap.insert(make_pair(allocCallBase,0));
                        FunctionToUnsafeCallBasesMap.insert(make_pair(allocCaller,ts));
                    }else{
                        if(CallBaseToUnsafeBitMap.find(allocCallBase) == CallBaseToUnsafeBitMap.end()){
                            auto fIT = FunctionToUnsafeCallBasesMap.find(allocCaller);
                            CallBaseToUnsafeBitMap.insert(make_pair(allocCallBase,0));
                            fIT->second.insert(allocCallBase);
                        }
                    }
                    if(CallBaseToUnsafeBitsArgs.find(allocCallBase) == CallBaseToUnsafeBitsArgs.end()){
                        set<int> ts;
                        ts.insert(1);
                        CallBaseToUnsafeBitsArgs.insert(make_pair(allocCallBase,ts));
                    }
                }
                CallBase* prev = allocCallBase;
                while(!calls.empty()){
                    const CallBlockNode* currCBN = _pta->getPTACallGraph()->getCallSite(calls.pop_back_val());
                    CallBase* currCB = const_cast<CallBase*>(llvm::cast<CallBase>(cbn->getCallSite()));
                    const SVFFunction* callee = SVFUtil::getCallee(currCB);
                    if(callee){
                        CallBaseToCalleeMap.insert(make_pair(currCB, callee->getLLVMFun()));
                    }else{
                        auto it = IndirectCallsToVirtualFunctionMap.find(currCB);
                        if(it == IndirectCallsToVirtualFunctionMap.end()){
                            set<Function*> fs;
                            fs.insert(prev->getFunction());
                            IndirectCallsToVirtualFunctionMap.insert(make_pair(currCB,fs));
                        }else{
                            it->second.insert(prev->getFunction());
                        }
                        IndirectlyDefined.insert(prev->getFunction());
                    }

                    LLVMContext &C = currCB->getContext();
                    MDNode *N = MDNode::get(C, MDString::get(C, "Unsafe call replacement"));
                    currCB->setMetadata("MPK-HEAP-MOVE", N);
                    UnsafeCallBases.insert(currCB);
                    Function* currParentFunc = cbn->getFun()->getLLVMFun();

                    if(FunctionToUnsafeCallBasesMap.find(currParentFunc) == FunctionToUnsafeCallBasesMap.end()){
                        set<CallBase*> ts;
                        ts.insert(currCB);
                        FunctionToUnsafeCallBasesMap.insert(make_pair(currParentFunc,ts));
                        CallBaseToUnsafeBitMap.insert(make_pair(currCB,0));
                    }else{
                        if(CallBaseToUnsafeBitMap.find(currCB) == CallBaseToUnsafeBitMap.end()){
                            auto fIT = FunctionToUnsafeCallBasesMap.find(currParentFunc);
                            CallBaseToUnsafeBitMap.insert(make_pair(currCB,fIT->second.size()));
                            fIT->second.insert(currCB);
                        }
                    }

                    if(CallBaseToUnsafeBitsArgs.find(currCB) == CallBaseToUnsafeBitsArgs.end()){
                        set<int> ts;
                        ts.insert(CallBaseToUnsafeBitMap[prev]);
                        CallBaseToUnsafeBitsArgs.insert(make_pair(currCB,ts));
                    }else{
                        CallBaseToUnsafeBitsArgs.find(currCB)->second.insert(CallBaseToUnsafeBitMap[prev]);
                    }

                    if(calls.empty()){
                        EntryReplaceCBNSet.insert(currCB);
                    }
                    prev = currCB;
                }

            }
        }else{
            const SVFGNode* node = dpm.getLoc();
            const Value* val = node->getValue();
            CallBase* allocCallBase = const_cast<CallBase*>(llvm::cast<CallBase>(val));
            if(allocCallBase->getCalledFunction()->getName().startswith("__mpk_unsafe")){
                continue;
            }
            Function* caller = allocCallBase->getParent()->getParent();
            Function* calledFunc = allocCallBase->getCalledFunction();
            CallBaseToCalleeMap.insert(make_pair(allocCallBase,calledFunc));
            EntryReplaceCBNSet.insert(allocCallBase);
            UnsafeCallBases.insert(allocCallBase);
            if(MpkRedefinedMap.find(calledFunc) == MpkRedefinedMap.end()){
                    ///define unsafe alloc func
                    Function* redefined = redefineFunction(calledFunc);
                    MpkRedefinedMap.insert(make_pair(calledFunc, redefined));
                    LLVMContext &C = allocCallBase->getContext();
                    MDNode *N = MDNode::get(C, MDString::get(C, "Unsafe call replacement"));
                    allocCallBase->setMetadata("MPK-HEAP-MOVE", N);
            }
            {
                Function* allocCaller = allocCallBase->getCalledFunction();
                if(FunctionToUnsafeCallBasesMap.find(allocCaller) == FunctionToUnsafeCallBasesMap.end()){
                    set<CallBase*> ts;
                    ts.insert(allocCallBase);
                    CallBaseToUnsafeBitMap.insert(make_pair(allocCallBase,0));
                    FunctionToUnsafeCallBasesMap.insert(make_pair(allocCaller,ts));
                }else{
                    if(CallBaseToUnsafeBitMap.find(allocCallBase) == CallBaseToUnsafeBitMap.end()){
                        auto fIT = FunctionToUnsafeCallBasesMap.find(allocCaller);
                        CallBaseToUnsafeBitMap.insert(make_pair(allocCallBase,0));
                        fIT->second.insert(allocCallBase);
                    }
                }
                if(CallBaseToUnsafeBitsArgs.find(allocCallBase) == CallBaseToUnsafeBitsArgs.end()){
                    set<int> ts;
                    ts.insert(1);
                    CallBaseToUnsafeBitsArgs.insert(make_pair(allocCallBase,ts));
                }
            }
            
        }
    }

    const set<CxtLocDPItem> unsafeStacks = ((ContextDDA*)_pta)->getFinalStackDpms();
    for(auto dpm: unsafeStacks){
        const SVFGNode* node = dpm.getLoc();
        const Value* val = node->getValue();
        if(const AllocaInst* inst = llvm::dyn_cast<AllocaInst>(val)){
            AllocaInst* allocaInst = const_cast<AllocaInst*>(inst);
            LLVMContext &C = allocaInst->getContext();
            MDNode *N = MDNode::get(C, MDString::get(C, "Unsafe stack object replacement"));
            allocaInst->setMetadata("MPK-Extern-Move", N);
            UnsafePointers.insert(node);
        }
    }

    
    for(auto id: pag->getAllValidPtrs()){
        PAGNode* node = pag->getPAGNode(id);
        if(node->isTopLevelPtr() && node->isPointer() && node->hasValue()){
            const Value* val = node->getValue();
            bool isUnsafe = false;
            if(val){
                if(const Instruction* inst = llvm::dyn_cast<Instruction>(val)){
                    if(inst->getMetadata("MPK-Unsafe") != nullptr){
                        isUnsafe = true;
                    }
                }

                if(!isUnsafe) {
                    for (auto user: val->users()) {
                        if (const Instruction *inst = llvm::dyn_cast<Instruction>(user)) {
                            if (inst->getMetadata("MPK-Unsafe") != nullptr) {
                                isUnsafe = true;
                                break;
                            }
                        }
                    }
                }
            }
            
            if(isUnsafe){
                auto pts = pta->getPts(id);
                const SVFGNode* snode = svfg->getDefSVFGNode(node);
                UnsafePointers.insert(snode);
                for(auto pt: pts){
                    const MemObj* obj = pag->getBaseObj(pt);
                    if(obj->isStack()){
                        AllocaInst* AI = const_cast<AllocaInst*>(llvm::cast<AllocaInst>(obj->getRefVal()));
                        if(AI->getMetadata("MPK-Extern-Move") == nullptr){
                            auto &cxt = AI->getContext();
                            MDNode* N = MDNode::get(cxt,MDString::get(cxt,"Unsafe stack object replacement"));
                            AI->setMetadata("MPK-Extern-Move", N);
                        }
                    }
                }
            }
        }
    }
}





void DDAPass::runOnModule(SVFModule* module)
{
    /// initialization for llvm alias analyzer
    //InitializeAliasAnalysis(this, SymbolTableInfo::getDataLayout(&module));

    
    selectClient(module);

    for (u32_t i = PointerAnalysis::FlowS_DDA;
         i < PointerAnalysis::Default_PTA; i++)
    {
        if (Options::DDASelected.isSet(i))
            runPointerAnalysis(module, i);
    }

    PAG* pag = _pta->getPAG();
    PTACallGraph* callGraph = _pta->getPTACallGraph();

    ///Compute call graphs/paths of Rust (de)alloc functions, mark entry callsites
    //constructAllocFuncCallGraphs(module,pag, callGraph,((ContextDDA*)_pta)->getSVFG());

    ///Find and mark unsafe pointers, unsafe alloc entry calls
    findUnsafePointers(_pta,((ContextDDA*)_pta)->getSVFG(),pag,module);

    traverseUnsafePointerCopies(((ContextDDA*)_pta)->getSVFG(), pag);

    removeDummyLoads(module);
    std::cout<<"Cloned Functions: "<<MpkRedefinedMap.size()<<std::endl;
    replaceUnsafeCalls();

    LLVMModuleSet::getLLVMModuleSet()->dumpModulesToFile(".bc");
}

bool DDAPass::runOnModule(Module& module)
{
    SVFModule* svfModule = LLVMModuleSet::getLLVMModuleSet()->buildSVFModule(module);
    runOnModule(svfModule);
    return false;
}

/// select a client to initialize queries
void DDAPass::selectClient(SVFModule* module)
{

    if (!Options::UserInputQuery.empty())
    {
        /// solve function pointer
        if (Options::UserInputQuery == "funptr")
        {
            _client = new FunptrDDAClient(module);
        }
        else if (Options::UserInputQuery == "alias")
        {
            _client = new AliasDDAClient(module);
        }
            /// allow user specify queries
        else
        {
            _client = new DDAClient(module);
            if (Options::UserInputQuery != "all")
            {
                u32_t buf; // Have a buffer
                stringstream ss(Options::UserInputQuery); // Insert the user input string into a stream
                while (ss >> buf)
                    _client->setQuery(buf);
            }
        }
    }
    else
    {
        assert(false && "Please specify query options!");
    }

    _client->initialise(module);
}

/// Create pointer analysis according to specified kind and analyze the module.
void DDAPass::runPointerAnalysis(SVFModule* module, u32_t kind)
{

    PAGBuilder builder;
    PAG* pag = builder.build(module);

    VFPathCond::setMaxPathLen(Options::MaxPathLen);
    ContextCond::setMaxCxtLen(Options::MaxContextLen);

    /// Initialize pointer analysis.
    switch (kind)
    {
        case PointerAnalysis::Cxt_DDA:
        {
            _pta = new ContextDDA(pag, _client);
            break;
        }
        case PointerAnalysis::FlowS_DDA:
        {
            _pta = new FlowDDA(pag, _client);
            break;
        }
        default:
            outs() << "This pointer analysis has not been implemented yet.\n";
            break;
    }

    if(Options::WPANum)
    {
        _client->collectWPANum(module);
    }
    else
    {
        ///initialize
        _pta->initialize();
        ///compute points-to
        _client->answerQueries(_pta);
        ///finalize
        _pta->finalize();
        if(Options::PrintCPts)
            _pta->dumpCPts();

        if (_pta->printStat())
            _client->performStat(_pta);

        if (Options::PrintQueryPts)
            printQueryPTS();
    }
}


/*!
 * Initialize context insensitive Edge for DDA
 */
void DDAPass::initCxtInsensitiveEdges(PointerAnalysis* pta, const SVFG* svfg,const SVFGSCC* svfgSCC, SVFGEdgeSet& insensitveEdges)
{
    if(Options::InsenRecur)
        collectCxtInsenEdgeForRecur(pta,svfg,insensitveEdges);
    else if(Options::InsenCycle)
        collectCxtInsenEdgeForVFCycle(pta,svfg,svfgSCC,insensitveEdges);
}

/*!
 * Whether SVFG edge in a SCC cycle
 */
bool DDAPass::edgeInSVFGSCC(const SVFGSCC* svfgSCC,const SVFGEdge* edge)
{
    return (svfgSCC->repNode(edge->getSrcID()) == svfgSCC->repNode(edge->getDstID()));
}

/*!
 *  Whether call graph edge in SVFG SCC
 */
bool DDAPass::edgeInCallGraphSCC(PointerAnalysis* pta,const SVFGEdge* edge)
{
    const SVFFunction* srcFun = edge->getSrcNode()->getICFGNode()->getFun();
    const SVFFunction* dstFun = edge->getDstNode()->getICFGNode()->getFun();

    if(srcFun && dstFun)
    {
        return pta->inSameCallGraphSCC(srcFun,dstFun);
    }

    assert(edge->isRetVFGEdge() == false && "should not be an inter-procedural return edge" );

    return false;
}

/*!
 * Mark insensitive edge for function recursions
 */
void DDAPass::collectCxtInsenEdgeForRecur(PointerAnalysis* pta, const SVFG* svfg,SVFGEdgeSet& insensitveEdges)
{

    for (SVFG::SVFGNodeIDToNodeMapTy::const_iterator it = svfg->begin(),eit = svfg->end(); it != eit; ++it)
    {

        SVFGEdge::SVFGEdgeSetTy::const_iterator edgeIt = it->second->InEdgeBegin();
        SVFGEdge::SVFGEdgeSetTy::const_iterator edgeEit = it->second->InEdgeEnd();
        for (; edgeIt != edgeEit; ++edgeIt)
        {
            const SVFGEdge* edge = *edgeIt;
            if(edge->isCallVFGEdge() || edge->isRetVFGEdge())
            {
                if(edgeInCallGraphSCC(pta,edge))
                    insensitveEdges.insert(edge);
            }
        }
    }
}

/*!
 * Mark insensitive edge for value-flow cycles
 */
void DDAPass::collectCxtInsenEdgeForVFCycle(PointerAnalysis* pta, const SVFG* svfg,const SVFGSCC* svfgSCC, SVFGEdgeSet& insensitveEdges)
{

    OrderedSet<NodePair> insensitvefunPairs;

    for (SVFG::SVFGNodeIDToNodeMapTy::const_iterator it = svfg->begin(),eit = svfg->end(); it != eit; ++it)
    {

        SVFGEdge::SVFGEdgeSetTy::const_iterator edgeIt = it->second->InEdgeBegin();
        SVFGEdge::SVFGEdgeSetTy::const_iterator edgeEit = it->second->InEdgeEnd();
        for (; edgeIt != edgeEit; ++edgeIt)
        {
            const SVFGEdge* edge = *edgeIt;
            if(edge->isCallVFGEdge() || edge->isRetVFGEdge())
            {
                if(this->edgeInSVFGSCC(svfgSCC,edge))
                {

                    const SVFFunction* srcFun = edge->getSrcNode()->getICFGNode()->getFun();
                    const SVFFunction* dstFun = edge->getDstNode()->getICFGNode()->getFun();

                    if(srcFun && dstFun)
                    {
                        NodeID src = pta->getPTACallGraph()->getCallGraphNode(srcFun)->getId();
                        NodeID dst = pta->getPTACallGraph()->getCallGraphNode(dstFun)->getId();
                        insensitvefunPairs.insert(std::make_pair(src,dst));
                        insensitvefunPairs.insert(std::make_pair(dst,src));
                    }
                    else
                        assert(edge->isRetVFGEdge() == false && "should not be an inter-procedural return edge" );
                }
            }
        }
    }

    for(SVFG::SVFGNodeIDToNodeMapTy::const_iterator it = svfg->begin(),eit = svfg->end(); it != eit; ++it)
    {
        SVFGEdge::SVFGEdgeSetTy::const_iterator edgeIt = it->second->InEdgeBegin();
        SVFGEdge::SVFGEdgeSetTy::const_iterator edgeEit = it->second->InEdgeEnd();
        for (; edgeIt != edgeEit; ++edgeIt)
        {
            const SVFGEdge* edge = *edgeIt;

            if(edge->isCallVFGEdge() || edge->isRetVFGEdge())
            {
                const SVFFunction* srcFun = edge->getSrcNode()->getICFGNode()->getFun();
                const SVFFunction* dstFun = edge->getDstNode()->getICFGNode()->getFun();

                if(srcFun && dstFun)
                {
                    NodeID src = pta->getPTACallGraph()->getCallGraphNode(srcFun)->getId();
                    NodeID dst = pta->getPTACallGraph()->getCallGraphNode(dstFun)->getId();
                    if(insensitvefunPairs.find(std::make_pair(src,dst))!=insensitvefunPairs.end())
                        insensitveEdges.insert(edge);
                    else if(insensitvefunPairs.find(std::make_pair(dst,src))!=insensitvefunPairs.end())
                        insensitveEdges.insert(edge);
                }
            }
        }
    }
}

AliasResult DDAPass::alias(NodeID node1, NodeID node2)
{
    PAG* pag = _pta->getPAG();

    if(pag->isValidTopLevelPtr(pag->getPAGNode(node1)))
        _pta->computeDDAPts(node1);

    if(pag->isValidTopLevelPtr(pag->getPAGNode(node2)))
        _pta->computeDDAPts(node2);

    return _pta->alias(node1,node2);
}
/*!
 * Return alias results based on our points-to/alias analysis
 * TODO: Need to handle PartialAlias and MustAlias here.
 */
AliasResult DDAPass::alias(const Value* V1, const Value* V2)
{
    PAG* pag = _pta->getPAG();

    /// TODO: When this method is invoked during compiler optimizations, the IR
    ///       used for pointer analysis may been changed, so some Values may not
    ///       find corresponding PAG node. In this case, we only check alias
    ///       between two Values if they both have PAG nodes. Otherwise, MayAlias
    ///       will be returned.
    if (pag->hasValueNode(V1) && pag->hasValueNode(V2))
    {
        PAGNode* node1 = pag->getPAGNode(pag->getValueNode(V1));
        if(pag->isValidTopLevelPtr(node1))
            _pta->computeDDAPts(node1->getId());

        PAGNode* node2 = pag->getPAGNode(pag->getValueNode(V2));
        if(pag->isValidTopLevelPtr(node2))
            _pta->computeDDAPts(node2->getId());

        return _pta->alias(V1,V2);
    }

    return llvm::MayAlias;
}

/*!
 * Print queries' pts
 */
void DDAPass::printQueryPTS()
{
    const OrderedNodeSet& candidates = _client->getCandidateQueries();
    for (OrderedNodeSet::const_iterator it = candidates.begin(), eit = candidates.end(); it != eit; ++it)
    {
        const PointsTo& pts = _pta->getPts(*it);
        _pta->dumpPts(*it,pts);
    }
}
