//===----- SVFModule.cpp  Base class of pointer analyses ---------------------//
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
//===----------------------------------------------------------------------===//

/*
 * SVFModule.cpp
 *
 *  Created on: Aug 4, 2017
 *      Author: Xiaokang Fan
 */

#include "Util/Options.h"
#include <queue>
#include "Util/SVFModule.h"
#include "Util/SVFUtil.h"
#include "SVF-FE/LLVMUtil.h"
#include "SVF-FE/SymbolTableInfo.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "RustIsolation/MPKRustIsolation.h"

using namespace std;
using namespace SVF;

/*
  svf.main() is used to model the real entry point of a C++ program,
  which initializes all global C++ objects and then call main().
  For example, given a "int main(int argc, char * argv[])", the corresponding
  svf.main will be generated as follows:
    define void @svf.main(i32, i8**, i8**) {
      entry:
        call void @_GLOBAL__sub_I_cast.cpp()
        call void @_GLOBAL__sub_I_1.cpp()
        call void @_GLOBAL__sub_I_2.cpp()
        %3 = call i32 @main(i32 %0, i8** %1)
        ret void
    }
 */
#define SVF_MAIN_FUNC_NAME           "svf.main"
#define SVF_GLOBAL_SUB_I_XXX          "_GLOBAL__sub_I_"

LLVMModuleSet *LLVMModuleSet::llvmModuleSet = nullptr;
std::string SVFModule::pagReadFromTxt = "";

SVFModule* LLVMModuleSet::buildSVFModule(Module &mod)
{
    svfModule = new SVFModule(mod.getModuleIdentifier());
    modules.emplace_back(mod);

    build();

    return svfModule;
}

SVFModule* LLVMModuleSet::buildSVFModule(const std::vector<std::string> &moduleNameVec)
{
    assert(llvmModuleSet && "LLVM Module set needs to be created!");

    // We read PAG from LLVM IR
    if(Options::Graphtxt.getValue().empty())
    {
        if(moduleNameVec.empty())
        {
            SVFUtil::outs() << "no LLVM bc file is found!\n";
            exit(0);
        }
        //assert(!moduleNameVec.empty() && "no LLVM bc file is found!");
    }
    // We read PAG from a user-defined txt instead of parsing PAG from LLVM IR
    else
        SVFModule::setPagFromTXT(Options::Graphtxt.getValue());

    if(!moduleNameVec.empty())
        svfModule = new SVFModule(*moduleNameVec.begin());
    else
        svfModule = new SVFModule();

    loadModules(moduleNameVec);
    build();

    return svfModule;
}

void LLVMModuleSet::build()
{
    initialize();
    buildFunToFunMap();
    buildGlobalDefToRepMap();

    if (!SVFModule::pagReadFromTXT()) {
        /// building symbol table
        DBOUT(DGENERAL,SVFUtil::outs() << SVFUtil::pasMsg("Building Symbol table ...\n"));
        SymbolTableInfo *symInfo = SymbolTableInfo::SymbolInfo();
        symInfo->buildMemModel(svfModule);
    }

}

void LLVMModuleSet::loadModules(const std::vector<std::string> &moduleNameVec)
{
    //
    // To avoid the following type bugs (t1 != t3) when parsing multiple modules,
    // We should use only one LLVMContext object for multiple modules in the same thread.
    // No such problem if only one module is processed by SVF.
    // ------------------------------------------------------------------
    //    LLVMContext ctxa,ctxb;
    //    IntegerType * t1 = IntegerType::get(ctxa,32);
    //    IntegerType * t2 = IntegerType::get(ctxa,32);
    //    assert(t1 == t2);
    //    IntegerType * t3 = IntegerType::get(ctxb,32);
    //    IntegerType * t4 = IntegerType::get(ctxb,32);
    //    assert(t3 == t4);
    //    assert(t1 != t3);
    // ------------------------------------------------------------------
    //
    cxts = std::make_unique<LLVMContext>();

    for (const std::string& moduleName : moduleNameVec) {
        SMDiagnostic Err;
        std::unique_ptr<Module> mod = parseIRFile(moduleName, Err, *cxts);
        if (mod == nullptr)
        {
            SVFUtil::errs() << "load module: " << moduleName << "failed!!\n\n";
            Err.print("SVFModuleLoader", SVFUtil::errs());
            continue;
        }
        modules.emplace_back(*mod);
        owned_modules.emplace_back(std::move(mod));
    }
}
/*!
 * Transform ExtractValue instructions to suitable load/gep instructions
 * @param M
 * @return
 */
bool ExtractValueTransform(Module& M){

    for(auto &F: M){
        std::vector<Instruction*> workList;
        for(auto &BB: F){
            for(auto &I: BB){
                if(ExtractValueInst* EVInst = llvm::dyn_cast<ExtractValueInst>(&I)){
                    Value* Agg = EVInst->getAggregateOperand();
                    if(!EVInst->hasIndices()){
                        EVInst->replaceAllUsesWith(Agg);
                        workList.push_back(EVInst);
                        continue;
                    }
                    if(Constant* C = llvm::dyn_cast<Constant>(Agg)) {
                        if (llvm::isa<UndefValue>(C)) {
                            EVInst->replaceAllUsesWith(UndefValue::get(EVInst->getType()));
                            workList.push_back(EVInst);
                            continue;
                        }
                        if (llvm::isa<llvm::ConstantAggregateZero>(C)) {
                            EVInst->replaceAllUsesWith(Constant::getNullValue(EVInst->getType()));
                            workList.push_back(EVInst);
                            continue;
                        }
                        if (llvm::isa<ConstantArray>(C) || llvm::isa<ConstantStruct>(C)) {
                            Value *V = C->getOperand(*EVInst->idx_begin());
                            if (EVInst->getNumIndices() > 1) {
                                ExtractValueInst *EVNew = ExtractValueInst::Create(V, EVInst->getIndices().slice(1), "",
                                                                                   EVInst);
                                EVInst->replaceAllUsesWith(EVNew);
                                workList.push_back(EVInst);
                            } else {
                                EVInst->replaceAllUsesWith(V);
                                workList.push_back(EVInst);
                            }
                        }
                        continue;
                    }

                    if(LoadInst* load = llvm::dyn_cast<LoadInst>(Agg)){
                        llvm::SmallVector<Value*,8> Indices;
                        Type *Int32Ty = Type::getInt32Ty(M.getContext());
                        Indices.push_back(Constant::getNullValue(Int32Ty));
                        for(ExtractValueInst::idx_iterator II = EVInst->idx_begin(), EI = EVInst->idx_end(); II != EI; ++II){
                            Indices.push_back(ConstantInt::get(Int32Ty, *II));
                        }

                        GetElementPtrInst *Gep = GetElementPtrInst::CreateInBounds(load->getPointerOperand(),Indices,"", EVInst);
                        LoadInst *newLoad = new LoadInst(EVInst->getType(),Gep,"",EVInst);
                        EVInst->replaceAllUsesWith(newLoad);
                        workList.push_back(EVInst);
                        continue;
                    }
                    if(InsertValueInst* IVInst = llvm::dyn_cast<InsertValueInst>(Agg)){
                        bool done = false;
                        const unsigned *exti, *exte, *insi, *inse;
                        for (exti = EVInst->idx_begin(), insi = IVInst->idx_begin(),
                             exte = EVInst->idx_end(), inse = IVInst->idx_end();
                             exti != exte && insi != inse;
                             ++exti, ++insi) {
                            if (*insi != *exti) {
                                /* The insert and extract both reference distinctly different elements.
                                 This means the extract is not influenced by the insert, and we can
                                 replace the aggregate operand of the extract with the aggregate
                                 operand of the insert. i.e., replace
                                 %I = insertvalue { i32, { i32 } } %A, { i32 } { i32 42 }, 1
                                 %E = extractvalue { i32, { i32 } } %I, 0
                                 with
                                 %E = extractvalue { i32, { i32 } } %A, 0
                                 */
                                ExtractValueInst *EV_new = ExtractValueInst::Create(IVInst->getAggregateOperand(),
                                                                                    EVInst->getIndices(), "", EVInst);
                                EVInst->replaceAllUsesWith(EV_new);
                                workList.push_back(EVInst);
                                done = true;
                                break;
                            }
                        }
                        if(done)
                            continue;
                        if (exti == exte && insi == inse) {
                            /* Both iterators are at the end: Index lists are identical. Replace
                             %B = insertvalue { i32, { i32 } } %A, i32 42, 1, 0
                             %C = extractvalue { i32, { i32 } } %B, 1, 0
                             with "i32 42"
                             */
                            EVInst->replaceAllUsesWith(IVInst->getInsertedValueOperand());
                            workList.push_back(EVInst);
                            continue;
                        }
                        if (exti == exte) {
                            /* The extract list is a prefix of the insert list. i.e. replace
                             %I = insertvalue { i32, { i32 } } %A, i32 42, 1, 0
                             %E = extractvalue { i32, { i32 } } %I, 1
                             with
                             %X = extractvalue { i32, { i32 } } %A, 1
                             %E = insertvalue { i32 } %X, i32 42, 0
                             by switching the order of the insert and extract (though the
                             insertvalue should be left in, since it may have other uses).
                             */
                            Value *NewEV = ExtractValueInst::Create(IVInst->getAggregateOperand(),
                                                                    EVInst->getIndices(), "", EVInst);
                            Value *NewIV = InsertValueInst::Create(NewEV, IVInst->getInsertedValueOperand(),
                                                                   llvm::makeArrayRef(insi, inse), "", EVInst);
                            EVInst->replaceAllUsesWith(NewIV);
                            workList.push_back(EVInst);
                            continue;
                        }
                        if (insi == inse) {
                             /*The insert list is a prefix of the extract list
                             We can simply remove the common indices from the extract and make it
                             operate on the inserted value instead of the insertvalue result.
                             i.e., replace
                             %I = insertvalue { i32, { i32 } } %A, { i32 } { i32 42 }, 1
                             %E = extractvalue { i32, { i32 } } %I, 1, 0
                             with
                             %E extractvalue { i32 } { i32 42 }, 0
                              */
                            ExtractValueInst *EV_new = ExtractValueInst::Create(IVInst->getInsertedValueOperand(),
                                                                                llvm::makeArrayRef(exti, exte), "", EVInst);
                            EVInst->replaceAllUsesWith(EV_new);
                            workList.push_back(EVInst);
                            continue;
                        }
                    }
                }
            }
        }
        while(!workList.empty()){
            Instruction *Inst = workList.back();
            workList.pop_back();
            Inst->eraseFromParent();
        }
    }
    return true;
}

/*!
 * Perform InsertValue instructions transform into store/gep instructions
 * @param M
 * @return true
 */
bool InsertValueTransform(Module& M){
    for(auto &F: M){
        std::vector<Instruction*> workList;
        for(auto &BB: F){
            for(auto &I: BB) {
                if (InsertValueInst *IVInst = llvm::dyn_cast<InsertValueInst>(&I)){
                    StoreInst* storeInst = nullptr;
                    if(llvm::isa<StoreInst>(*IVInst->user_begin())){
                        storeInst = llvm::cast<StoreInst>(*IVInst->user_begin());
                    }else if(llvm::isa<ReturnInst>(*IVInst->user_begin()) || llvm::isa<ResumeInst>(*IVInst->user_begin())){
                        ///create alloca, store followed by a load
                        Instruction* inst = llvm::cast<Instruction>(*IVInst->user_begin());
                        AllocaInst *allocaInst = new AllocaInst(IVInst->getType(),IVInst->getType()->getPrimitiveSizeInBits(), "",inst);
                        storeInst = new StoreInst(IVInst,allocaInst,inst);
                        LoadInst * loadInst = new LoadInst(IVInst->getType(),allocaInst,"",inst);
                        if(ReturnInst* ret = llvm::dyn_cast<ReturnInst>(inst)){
                            ret->setOperand(0,loadInst);
                        }else if(ResumeInst* res = llvm::dyn_cast<ResumeInst>(inst)){
                            res->setOperand(0,loadInst);
                        }
                    }else{
                        continue;
                    }

                    if(!storeInst || storeInst->getOperand(0) != IVInst)
                        continue;

                    do{
                        llvm::SmallVector<Value*,8> Indices;
                        Type *Int32Ty = Type::getInt32Ty(M.getContext());
                        Indices.push_back(Constant::getNullValue(Int32Ty));
                        for(InsertValueInst::idx_iterator II = IVInst->idx_begin(), IE = IVInst->idx_end(); II != IE; ++II){
                            Indices.push_back(ConstantInt::get(Int32Ty,*II));
                        }
                        GetElementPtrInst *Gep = GetElementPtrInst::CreateInBounds(storeInst->getOperand(1), Indices,storeInst->getName(),storeInst);
                        new StoreInst(IVInst->getInsertedValueOperand(),Gep,storeInst);
                        workList.push_back(IVInst);
                        IVInst = llvm::dyn_cast<InsertValueInst>(IVInst->getAggregateOperand());
                    }while(IVInst);
                    workList.push_back(storeInst);
                }
            }
        }
        while(!workList.empty()){
            Instruction *Inst = workList.back();
            workList.pop_back();
            Inst->eraseFromParent();
        }
    }
    return true;
}

Function* redefineStructRetFunction(Function* F){
    std::vector<Type*> ArgTypes;
    llvm::ValueToValueMapTy VMap;
    // The user might be deleting arguments to the function by specifying them in
    // the VMap.  If so, we need to not add the arguments to the arg ty vector
    for (const Argument &I : F->args())
        if (VMap.count(&I) == 0) // Haven't mapped the argument to anything yet?
            ArgTypes.push_back(I.getType());

    ArgTypes.push_back(F->getReturnType()->getPointerTo());

    // Create a new function type...
    FunctionType *FTy = FunctionType::get(F->getFunctionType()->getReturnType(),
                                          ArgTypes, F->getFunctionType()->isVarArg());

    // Create the new function...
    Function *NewF = Function::Create(FTy, F->getLinkage(), F->getAddressSpace(),
                                      "__mpk_struct_ret_trans_"+F->getName().str(), F->getParent());

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

bool addDummyLoads(Module& M){
    strapAndMarkRustStdLibraries(M);
    for(auto &F: M){
        if(F.isDeclaration() && !isRustLibraryFunc(&F)){
            continue;
        }
        for(auto &BB: F) {
            for (auto &I: BB) {
                if(LoadInst* load = llvm::dyn_cast<LoadInst>(&I)) {
                    if (load->getMetadata("MPK-Unsafe") != nullptr && !load->getType()->isPointerTy()) {
                        Value *loadSrc = load->getPointerOperand();
                        BitCastInst *bitCastInst = new BitCastInst(loadSrc, loadSrc->getType()->getPointerTo(0),
                                                                   "dummy_bit_cast", &I);
                        LoadInst *dummyLoad = new LoadInst(loadSrc->getType(), bitCastInst, "", &I);
                        LLVMContext &C = load->getContext();
                        MDNode *N = MDNode::get(C, MDString::get(C, "Dummy Load To help with PTA"));
                        dummyLoad->setMetadata("MPK-Dummy-Load", N);
                        bitCastInst->setMetadata("MPK-Dummy-Load", N);
                        MDNode *NN = MDNode::get(C,
                                                 MDString::get(C, "Dummy Unsafe load_store to help with PTA"));
                        dummyLoad->setMetadata("MPK-Unsafe", NN);
                    }
                }else if(StoreInst* store = llvm::dyn_cast<StoreInst>(&I)){
                        if(store->getMetadata("MPK-Unsafe") != nullptr && !store->getOperand(0)->getType()->isPointerTy()){
                            Value* storeDst = store->getPointerOperand();
                            BitCastInst *bitCastInst = new BitCastInst(storeDst, storeDst->getType()->getPointerTo(0),
                                                                       "dummy_bit_cast", &I);
                            StoreInst *dummyStore = new StoreInst(storeDst,bitCastInst,store);
                            LLVMContext &C = store->getContext();
                            MDNode *N = MDNode::get(C, MDString::get(C, "Dummy Load To help with PTA"));
                            dummyStore->setMetadata("MPK-Dummy-Load", N);
                            bitCastInst->setMetadata("MPK-Dummy-Load", N);
                            MDNode *NN = MDNode::get(C,MDString::get(C,"Dummy Unsafe load_store to help with PTA"));
                            dummyStore->setMetadata("MPK-Unsafe",NN);
                        }
                }else if(CallBase* CB = llvm::dyn_cast<CallBase>(&I)){
                    if(CB->getMetadata("MPK-Unsafe") != nullptr){
                        for(auto &callArg: CB->args()){
                            if(callArg->getType()->isPointerTy()){
                                BitCastInst *bitCastInst = new BitCastInst(callArg, callArg->getType()->getPointerTo(0),
                                                                           "dummy_bit_cast", &I);
                                LoadInst *dummyLoad = new LoadInst(callArg->getType(), bitCastInst, "", &I);
                                LLVMContext &C = CB->getContext();
                                MDNode *N = MDNode::get(C, MDString::get(C, "Dummy Load To help with PTA"));
                                dummyLoad->setMetadata("MPK-Dummy-Load", N);
                                bitCastInst->setMetadata("MPK-Dummy-Load", N);
                                MDNode *NN = MDNode::get(C,MDString::get(C,"Dummy Unsafe load_store to help with PTA"));
                                dummyLoad->setMetadata("MPK-Unsafe",NN);
                            }
                        }
                    }
                }
            }
        }
    }

    return true;
}

void LLVMModuleSet::initialize()
{
    if (Options::SVFMain)
        addSVFMain();

    for(Module& M: modules){
        addDummyLoads(M);
    }

    for (Module& mod : modules)
    {
        /// Function
        for (Module::iterator it = mod.begin(), eit = mod.end();
                it != eit; ++it)
        {
            Function *func = &*it;
            svfModule->addFunctionSet(func);
        }

        /// GlobalVariable
        for (Module::global_iterator it = mod.global_begin(),
                eit = mod.global_end(); it != eit; ++it)
        {
            GlobalVariable *global = &*it;
            svfModule->addGlobalSet(global);
        }

        /// GlobalAlias
        for (Module::alias_iterator it = mod.alias_begin(),
                eit = mod.alias_end(); it != eit; ++it)
        {
            GlobalAlias *alias = &*it;
            svfModule->addAliasSet(alias);
        }
    }
}

void LLVMModuleSet::addSVFMain()
{
    std::vector<Function *> init_funcs;
    Function * orgMain = 0;
    Module* mainMod = nullptr;
    for (Module& mod : modules)
    {
        for (auto &func: mod)
        {
            if(func.getName().startswith(SVF_GLOBAL_SUB_I_XXX))
                init_funcs.push_back(&func);
            if(func.getName().equals(SVF_MAIN_FUNC_NAME))
                assert(false && SVF_MAIN_FUNC_NAME " already defined");
            if(func.getName().equals("main"))
            {
                orgMain = &func;
                mainMod = &mod;
            }
        }
    }
    if(orgMain && getModuleNum() > 0 && init_funcs.size() > 0)
    {
        assert(mainMod && "Module with main function not found.");
        Module & M = *mainMod;
        // char **
        Type * i8ptr2 = PointerType::getInt8PtrTy(M.getContext())->getPointerTo();
        Type * i32 = IntegerType::getInt32Ty(M.getContext());
        // define void @svf.main(i32, i8**, i8**)
#if (LLVM_VERSION_MAJOR >= 9)
        FunctionCallee svfmainFn = M.getOrInsertFunction(
                                       SVF_MAIN_FUNC_NAME,
                                       Type::getVoidTy(M.getContext()),
                                       i32,i8ptr2,i8ptr2
                                   );
        Function *svfmain = SVFUtil::dyn_cast<Function>(svfmainFn.getCallee());
#else
        Function *svfmain = SVFUtil::dyn_cast<Function>(M.getOrInsertFunction(
                                SVF_MAIN_FUNC_NAME,
                                Type::getVoidTy(M.getContext()),
                                i32,i8ptr2,i8ptr2
                            ));
#endif
        svfmain->setCallingConv(llvm::CallingConv::C);
        BasicBlock* block = BasicBlock::Create(M.getContext(), "entry", svfmain);
        IRBuilder Builder(block);
        // emit "call void @_GLOBAL__sub_I_XXX()"
        for(auto & init: init_funcs)
        {
            auto target = M.getOrInsertFunction(
                              init->getName(),
                              Type::getVoidTy(M.getContext())
                          );
            Builder.CreateCall(target);
        }
        // main() should be called after all _GLOBAL__sub_I_XXX functions.
        Function::arg_iterator arg_it = svfmain->arg_begin();
        Value * args[] = {arg_it, arg_it + 1, arg_it + 2 };
        size_t cnt = orgMain->arg_size();
        assert(cnt <= 3 && "Too many arguments for main()");
        Builder.CreateCall(orgMain, llvm::ArrayRef<Value*>(args,args + cnt));
        // return;
        Builder.CreateRetVoid();
    }
}


void LLVMModuleSet::buildFunToFunMap()
{
    Set<Function*> funDecls, funDefs;
    Set<string> declNames, defNames, intersectNames;
    typedef Map<string, Function*> NameToFunDefMapTy;
    typedef Map<string, Set<Function*>> NameToFunDeclsMapTy;

    for (SVFModule::LLVMFunctionSetType::iterator it = svfModule->llvmFunBegin(),
            eit = svfModule->llvmFunEnd(); it != eit; ++it)
    {
        Function *fun = *it;
        if (fun->isDeclaration())
        {
            funDecls.insert(fun);
            declNames.insert(fun->getName().str());
        }
        else
        {
            funDefs.insert(fun);
            defNames.insert(fun->getName().str());
        }
    }
    // Find the intersectNames
    Set<string>::iterator declIter, defIter;
    declIter = declNames.begin();
    defIter = defNames.begin();
    while (declIter != declNames.end() && defIter != defNames.end())
    {
        if (*declIter < *defIter)
        {
            declIter++;
        }
        else
        {
            if (!(*defIter < *declIter))
            {
                intersectNames.insert(*declIter);
                declIter++;
            }
            defIter++;
        }
    }

    ///// name to def map
    NameToFunDefMapTy nameToFunDefMap;
    for (Set<Function*>::iterator it = funDefs.begin(),
            eit = funDefs.end(); it != eit; ++it)
    {
        Function *fdef = *it;
        string funName = fdef->getName().str();
        if (intersectNames.find(funName) == intersectNames.end())
            continue;
        nameToFunDefMap[funName] = fdef;
    }

    ///// name to decls map
    NameToFunDeclsMapTy nameToFunDeclsMap;
    for (Set<Function*>::iterator it = funDecls.begin(),
            eit = funDecls.end(); it != eit; ++it)
    {
        Function *fdecl = *it;
        string funName = fdecl->getName().str();
        if (intersectNames.find(funName) == intersectNames.end())
            continue;
        NameToFunDeclsMapTy::iterator mit = nameToFunDeclsMap.find(funName);
        if (mit == nameToFunDeclsMap.end())
        {
            Set<Function*> decls;
            decls.insert(fdecl);
            nameToFunDeclsMap[funName] = decls;
        }
        else
        {
            Set<Function*> &decls = mit->second;
            decls.insert(fdecl);
        }
    }

    /// Fun decl --> def
    for (Set<Function*>::iterator it = funDecls.begin(),
            eit = funDecls.end(); it != eit; ++it)
    {
        const Function *fdecl = *it;
        string funName = fdecl->getName().str();
        if (intersectNames.find(funName) == intersectNames.end())
            continue;
        NameToFunDefMapTy::iterator mit = nameToFunDefMap.find(funName);
        if (mit == nameToFunDefMap.end())
            continue;
        FunDeclToDefMap[svfModule->getSVFFunction(fdecl)] = svfModule->getSVFFunction(mit->second);
    }

    /// Fun def --> decls
    for (Set<Function*>::iterator it = funDefs.begin(),
            eit = funDefs.end(); it != eit; ++it)
    {
        const Function *fdef = *it;
        string funName = fdef->getName().str();
        if (intersectNames.find(funName) == intersectNames.end())
            continue;
        NameToFunDeclsMapTy::iterator mit = nameToFunDeclsMap.find(funName);
        if (mit == nameToFunDeclsMap.end())
            continue;
        std::vector<const SVFFunction*>& decls = FunDefToDeclsMap[svfModule->getSVFFunction(fdef)];
        for (Set<Function*>::iterator sit = mit->second.begin(),
                seit = mit->second.end(); sit != seit; ++sit)
        {
            decls.push_back(svfModule->getSVFFunction(*sit));
        }
    }
}

void LLVMModuleSet::buildGlobalDefToRepMap()
{
    typedef Map<string, Set<GlobalVariable*>> NameToGlobalsMapTy;
    NameToGlobalsMapTy nameToGlobalsMap;
    for (SVFModule::global_iterator it = svfModule->global_begin(),
            eit = svfModule->global_end(); it != eit; ++it)
    {
        GlobalVariable *global = *it;
        if (global->hasPrivateLinkage())
            continue;
        string name = global->getName().str();
        NameToGlobalsMapTy::iterator mit = nameToGlobalsMap.find(name);
        if (mit == nameToGlobalsMap.end())
        {
            Set<GlobalVariable*> globals;
            globals.insert(global);
            nameToGlobalsMap[name] = globals;
        }
        else
        {
            Set<GlobalVariable*> &globals = mit->second;
            globals.insert(global);
        }
    }

    for (NameToGlobalsMapTy::iterator it = nameToGlobalsMap.begin(),
            eit = nameToGlobalsMap.end(); it != eit; ++it)
    {
        Set<GlobalVariable*> &globals = it->second;
        GlobalVariable *rep = *(globals.begin());
        Set<GlobalVariable*>::iterator repit = globals.begin();
        while (repit != globals.end())
        {
            GlobalVariable *cur = *repit;
            if (cur->hasInitializer())
            {
                rep = cur;
                break;
            }
            repit++;
        }
        for (Set<GlobalVariable*>::iterator sit = globals.begin(),
                seit = globals.end(); sit != seit; ++sit)
        {
            GlobalVariable *cur = *sit;
            GlobalDefToRepMap[cur] = rep;
        }
    }
}

// Dump modules to files
void LLVMModuleSet::dumpModulesToFile(const std::string suffix)
{
    for (Module& mod : modules)
    {
        std::string moduleName = mod.getName().str();
        std::string OutputFilename;
        std::size_t pos = moduleName.rfind('.');
        if (pos != std::string::npos)
            OutputFilename = moduleName.substr(0, pos) + suffix;
        else
            OutputFilename = moduleName + suffix;

        std::error_code EC;
        raw_fd_ostream OS(OutputFilename.c_str(), EC, llvm::sys::fs::F_None);

        raw_fd_ostream OS2((OutputFilename+".ll").c_str(), EC, llvm::sys::fs::F_None);
        mod.print(OS2, nullptr);
#if (LLVM_VERSION_MAJOR >= 7)
        WriteBitcodeToFile(mod, OS);
#else
        WriteBitcodeToFile(&mod, OS);
#endif

        OS.flush();
    }
}
