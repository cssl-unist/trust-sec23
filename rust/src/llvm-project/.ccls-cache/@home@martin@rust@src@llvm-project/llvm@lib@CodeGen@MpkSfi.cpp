#include "llvm/Transforms/MpkSfi.h"
#include "llvm/ADT/APInt.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/Analysis/InlineCost.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/StackLifetime.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/CodeGen/TargetLowering.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/IR/Argument.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/ConstantRange.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DIBuilder.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/MDBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Use.h"
#include "llvm/IR/User.h"
#include "llvm/IR/Value.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/Local.h"
#include <algorithm>
#include <cassert>
#include <cstdint>
#include <llvm/IR/BasicBlock.h>
#include <string>
#include <utility>


#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/DerivedTypes.h"
// #include "llvm/IR/TypeBuilder.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/InlineAsm.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"


#include "llvm/Transforms/MpkIsolation.h"


#define SFI_TESTPASS_NAME "sfi-testpass"

using namespace llvm;

namespace {


  class SfiTestPass : public ModulePass{
  public:
    static char ID;
    SfiTestPass() : ModulePass(ID) {
      initializeSfiTestPassPass(*PassRegistry::getPassRegistry());
    }

    bool runOnModule(Module &M) override;

    //bool runOnModule

    //    const char *getPassName() const override {
    StringRef getPassName() const override {
      return SFI_TESTPASS_NAME;
    }

    // FunctionPass* createSfiTestPassPass();

    // extern void __sfi_exception(void* addr);

  };
}

bool SfiTestPass::runOnModule(Module &M) {
  if(!llvm::shouldHookWithMpkIsolation()){
    return false;
  }
  return false;
  bool Modified = false;
  LLVMContext &Context = M.getContext();
  bool unsafety = false;

  for(Function &F: M){
    for(Function::iterator BB = F.begin(), BE = F.end(); BB != BE; ++BB){
      BasicBlock& B = *BB;
      for(BasicBlock::iterator II = B.begin(), IE = B.end(); II != IE; ++II){
        Instruction& I = *II;
        IRBuilder<> IRB(&I);//inserted before the instruction
        FunctionType* voidTypeWithInt32 = FunctionType::get(Type::getVoidTy(Context),
                                                             {Type::getInt32Ty(Context)}, false);
        //arg i8*
        FunctionCallee c0 = M.getOrInsertFunction("set_domain_value",
                                                    voidTypeWithInt32
                                                    );

        Value* DV2 = llvm::ConstantInt::get(Context, llvm::APInt(/*nbits*/32, 2, true));
        Value* DV0 = llvm::ConstantInt::get(Context, llvm::APInt(/*nbits*/32, 0, true));

        if(I.getMetadata("MPK-Unsafe")!= nullptr){
          if(unsafety == false){
            unsafety = true;
            Instruction *CI = CallInst::Create(c0, {DV2}, "", &I);
          }
        }
        else{
          if(unsafety == true){
            unsafety = false;
            IRB.CreateCall(c0, {DV0});//insert before
          }
        }
        if(StoreInst *LI = dyn_cast<StoreInst>(&I)){
          //Target i8**
          Value * Target = LI->getOperand(1);
          if (isa<Constant>(Target)) {
            continue;
          }
          DataLayout DL = M.getDataLayout();
          Type* IntPtrTy = DL.getIntPtrType(M.getContext());
          Value *Mask = llvm::ConstantInt::get(Context, llvm::APInt(/*nbits*/64, /*value*/0xfffffffffffffffeUL, /*bool*/0)); //dummy value to measure performance
          Value *PtrVal = IRB.CreatePtrToInt(Target, IntPtrTy);
          Value *MaskedVal = IRB.CreateAnd(PtrVal, Mask);
          Modified = true;
          LI->replaceUsesOfWith(Target, MaskedVal);

        }
      }
    }
  }
  //for(auto &B: F){

  return Modified;
}

char SfiTestPass::ID = 0;
INITIALIZE_PASS_BEGIN(SfiTestPass, "Mpk Sfi","Mpk Isolation sfi Pass", false, false)
INITIALIZE_PASS_END(SfiTestPass, "Mpk Sfi", "Mpk Isolation sfi pass", false, false)
ModulePass* llvm::createSfiTestPass() {
  return new SfiTestPass();
}
