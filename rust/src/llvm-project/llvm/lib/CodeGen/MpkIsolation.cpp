/* Part of the MPK Isolation interface for Rust,
 * Inserts function calls for entering and exiting external domains,
 * Inserts implementation for copying pointer argument content to
 * unsafe regions
 */
#define STORE_FALSE_NEGATIVE_CHECK_FUNC_NAME "__check_store_false_negative"
#define LOAD_FALSE_NEGATIVE_CHECK_FUNC_NAME "__check_load_false_negative"
#define STORE_FALSE_POSITIVE_CHECK_FUNC_NAME "__check_store_false_positive"
#define LOAD_FALSE_POSITIVE_CHECK_FUNC_NAME "__check_load_false_positive"

#include "llvm/Transforms/MpkIsolation.h"
#include "SafeStackLayout.h"
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

using namespace llvm;
using namespace llvm::safestack;
namespace {
/* Borrowed from SafeStack.cpp */
/// Rewrite an SCEV expression for a memory access address to an expression that
/// represents offset from the given alloca.
///
/// The implementation simply replaces all mentions of the alloca with zero.
class AllocaOffsetRewriter : public SCEVRewriteVisitor<AllocaOffsetRewriter> {
  const Value *AllocaPtr;

public:
  AllocaOffsetRewriter(ScalarEvolution &SE, const Value *AllocaPtr)
      : SCEVRewriteVisitor(SE), AllocaPtr(AllocaPtr) {}

  const SCEV *visitUnknown(const SCEVUnknown *Expr) {
    if (Expr->getValue() == AllocaPtr)
      return SE.getZero(Expr->getType());
    return Expr;
  }
};

//  static std::map<Function* /* Caller*/,
//                  SmallMapVector<Function* /* callee */
//                  SmallVector<int, 4> /* pointer args for tracking and their
//                  arg indices */, 4>> ExternCallerCalleeMap;

class MPKExternStack {
  Function &F;
  const TargetLoweringBase &TL;
  const DataLayout &DL;
  ScalarEvolution &SE;

  Type *StackPtrTy;
  Type *IntPtrTy;
  Type *Int32Ty;
  Type *Int8Ty;

  Value *ExternStackPtr = nullptr;

  enum { StackAlignment = 16 };
  uint64_t getStaticAllocaAllocationSize(AllocaInst *AI);

public:
  MPKExternStack(Function &F, const TargetLoweringBase &TL,
                 const DataLayout &DL, ScalarEvolution &SE)
      : F(F), TL(TL), DL(DL), SE(SE),
        StackPtrTy(Type::getInt8PtrTy(F.getContext())),
        IntPtrTy(DL.getIntPtrType(F.getContext())),
        Int32Ty(Type::getInt32Ty(F.getContext())),
        Int8Ty(Type::getInt8Ty(F.getContext())) {}

  Value *moveStaticAllocasToExternStack(IRBuilder<> &IRB, Function &F,
                                        ArrayRef<AllocaInst *> StaticAllocas,
                                        Instruction *BasePtr);
  void moveDynamicAllocasToExternStack(Function &F, Value *ExternStackPtr,
                                       AllocaInst *DynamicTop,
                                       ArrayRef<AllocaInst *> DynamicAllocas);
  AllocaInst *
  createStackRestorePoints(IRBuilder<> &IRB, Function &F,
                           ArrayRef<Instruction *> StackRestorePoints,
                           Value *StaticTop, bool NeedDynamicTop);

  void run(ArrayRef<AllocaInst *> StaticAllocas,
           ArrayRef<AllocaInst *> DynamicAllocas,
           ArrayRef<Instruction *> StackRestorePoints, ArrayRef<ReturnInst *>);
};
} // namespace

uint64_t MPKExternStack::getStaticAllocaAllocationSize(AllocaInst *AI) {
  uint64_t Size = DL.getTypeAllocSize(AI->getAllocatedType());
  if (AI->isArrayAllocation()) {
    auto C = dyn_cast<ConstantInt>(AI->getArraySize());
    if (!C)
      return 0;
    Size *= C->getZExtValue();
  }

  return Size;
}

void MPKExternStack::moveDynamicAllocasToExternStack(
    Function &F, Value *ExternStackPtr, AllocaInst *DynamicTop,
    ArrayRef<AllocaInst *> DynamicAllocas) {
  errs() << "Moving dynamic allocas\n";
  DIBuilder DIB(*F.getParent());
  for (AllocaInst *AI : DynamicAllocas) {
    errs() << *AI << "\n";
    IRBuilder<> IRB(AI);
    Value *ArraySize = AI->getArraySize();
    if (ArraySize->getType() != IntPtrTy)
      ArraySize = IRB.CreateIntCast(ArraySize, IntPtrTy, false);

    Type *Ty = AI->getAllocatedType();
    u_int64_t TySize = DL.getTypeAllocSize(Ty);
    Value *Size = IRB.CreateMul(ArraySize, ConstantInt::get(IntPtrTy, TySize));
    Value *SP = IRB.CreatePtrToInt(IRB.CreateLoad(StackPtrTy, ExternStackPtr),
                                   IntPtrTy);
    SP = IRB.CreateSub(SP, Size);

    unsigned Align = std::max(
        std::max((unsigned)DL.getPrefTypeAlignment(Ty), AI->getAlignment()),
        (unsigned)StackAlignment);

    assert(isPowerOf2_32(Align));
    Value *NewTop = IRB.CreateIntToPtr(
        IRB.CreateAnd(SP, ConstantInt::get(IntPtrTy, ~u_int64_t(Align - 1))),
        StackPtrTy);
    IRB.CreateStore(NewTop, ExternStackPtr);
    if (DynamicTop)
      IRB.CreateStore(NewTop, DynamicTop);

    Value *NewAI = IRB.CreatePointerCast(NewTop, AI->getType());
    if (AI->hasName() && isa<Instruction>(NewAI))
      NewAI->takeName(AI);

    replaceDbgDeclare(AI, NewAI, DIB, DIExpression::ApplyOffset, 0);
    AI->replaceAllUsesWith(NewAI);
    AI->eraseFromParent();
  }

  if (!DynamicAllocas.empty()) {
    for (inst_iterator It = inst_begin(&F), Ie = inst_end(&F); It != Ie;) {
      Instruction *I = &*(It++);
      auto II = dyn_cast<IntrinsicInst>(I);
      if (!II)
        continue;

      if (II->getIntrinsicID() == Intrinsic::stacksave) {
        IRBuilder<> IRB(II);
        Instruction *LI = IRB.CreateLoad(StackPtrTy, ExternStackPtr);
        LI->takeName(II);
        II->replaceAllUsesWith(LI);
        II->eraseFromParent();
      } else if (II->getIntrinsicID() == Intrinsic::stackrestore) {
        IRBuilder<> IRB(II);
        Instruction *SI = IRB.CreateStore(II->getArgOperand(0), ExternStackPtr);
        SI->takeName(II);
        assert(II->use_empty());
        II->eraseFromParent();
      }
    }
  }

  errs() << "Moved dynamic allocas\n";
}

AllocaInst *MPKExternStack::createStackRestorePoints(
    IRBuilder<> &IRB, Function &F, ArrayRef<Instruction *> StackRestorePoints,
    Value *StaticTop, bool NeedDynamicTop) {
  assert(StaticTop && "The stack top isn't set.");

  if (StackRestorePoints.empty())
    return nullptr;

  // We need the current value of the shadow stack pointer to restore
  // after longjmp or exception catching.

  // FIXME: On some platforms this could be handled by the longjmp/exception
  // runtime itself.

  AllocaInst *DynamicTop = nullptr;
  if (NeedDynamicTop) {
    // If we also have dynamic alloca's, the stack pointer value changes
    // throughout the function. For now we store it in an alloca.
    DynamicTop = IRB.CreateAlloca(StackPtrTy, /*ArraySize=*/nullptr,
                                  "unsafe_stack_dynamic_ptr");
    IRB.CreateStore(StaticTop, DynamicTop);
  }

  // Restore current stack pointer after longjmp/exception catch.
  for (Instruction *I : StackRestorePoints) {

    IRB.SetInsertPoint(I->getNextNode());
    Value *CurrentTop =
        DynamicTop ? IRB.CreateLoad(StackPtrTy, DynamicTop) : StaticTop;
    IRB.CreateStore(CurrentTop, ExternStackPtr);
  }

  return DynamicTop;
}

Value *MPKExternStack::moveStaticAllocasToExternStack(
    IRBuilder<> &IRB, Function &F, ArrayRef<AllocaInst *> StaticAllocas,
    Instruction *BasePtr) {
  if (StaticAllocas.empty())
    return BasePtr;

  errs() << "Moving static allocas\n";
  DIBuilder DIB(*F.getParent());

  StackLifetime SSC(F, StaticAllocas, StackLifetime::LivenessType::May);
  static const StackLifetime::LiveRange NoColoringRange(1, true);

  for (auto *I : SSC.getMarkers()) {
    auto *Op = dyn_cast<Instruction>(I->getOperand(1));
    const_cast<IntrinsicInst *>(I)->eraseFromParent();
    if (Op && Op->use_empty())
      Op->eraseFromParent();
  }

  StackLayout SSL(StackAlignment);
  for (AllocaInst *AI : StaticAllocas) {
    Type *Ty = AI->getAllocatedType();
    u_int64_t Size = getStaticAllocaAllocationSize(AI);
    if (Size == 0)
      Size = 1;

    unsigned Align =
        std::max((unsigned)DL.getPrefTypeAlignment(Ty), AI->getAlignment());
    SSL.addObject(AI, Size, Align, NoColoringRange);
  }

  SSL.computeLayout();
  unsigned FrameAlignment = SSL.getFrameAlignment();

  if (FrameAlignment > StackAlignment) {
    assert(isPowerOf2_32(FrameAlignment));
    IRB.SetInsertPoint(BasePtr->getNextNode());
    BasePtr = cast<Instruction>(IRB.CreateIntToPtr(
        IRB.CreateAnd(
            IRB.CreatePtrToInt(BasePtr, IntPtrTy),
            ConstantInt::get(IntPtrTy, ~u_int64_t(FrameAlignment - 1))),
        StackPtrTy));
  }

  IRB.SetInsertPoint(BasePtr->getNextNode());

  for (AllocaInst *AI : StaticAllocas) {
    errs() << *AI << "\n";
    IRB.SetInsertPoint(AI);
    unsigned Offset = SSL.getObjectOffset(AI);
    replaceDbgDeclare(AI, BasePtr, DIB, DIExpression::ApplyOffset, -Offset);
    replaceDbgValueForAlloca(AI, BasePtr, DIB, -Offset);

    std::string Name = std::string(AI->getName()) + ".mpk_extern";
    while (!AI->use_empty()) {
      Use &U = *AI->use_begin();
      Instruction *User = cast<Instruction>(U.getUser());

      Instruction *InsertBefore;
      if (auto *PHI = dyn_cast<PHINode>(User))
        InsertBefore = PHI->getIncomingBlock(U)->getTerminator();
      else
        InsertBefore = User;

      IRBuilder<> IRBUser(InsertBefore);
      Value *Off = IRBUser.CreateGEP(Int8Ty, BasePtr,
                                     ConstantInt::get(Int32Ty, -Offset));
      Value *Replacement = IRBUser.CreateBitCast(Off, AI->getType(), Name);

      if (auto *PHI = dyn_cast<PHINode>(User))
        PHI->setIncomingValueForBlock(PHI->getIncomingBlock(U), Replacement);
      else
        U.set(Replacement);
    }
    AI->eraseFromParent();
  }

  unsigned FrameSize = alignTo(SSL.getFrameSize(), StackAlignment);
  IRB.SetInsertPoint(BasePtr->getNextNode());

  Value *StaticTop =
      IRB.CreateGEP(Int8Ty, BasePtr, ConstantInt::get(Int32Ty, -FrameSize),
                    "extern_stack_top");
  IRB.CreateStore(StaticTop, ExternStackPtr);
  errs() << "Moved static allocas\n";
  return StaticTop;
}

void MPKExternStack::run(ArrayRef<AllocaInst *> StaticAllocas,
                         ArrayRef<AllocaInst *> DynamicAllocas,
                         ArrayRef<Instruction *> StackRestorePoints,
                         ArrayRef<ReturnInst *> Returns) {
  IRBuilder<> IRB(&F.front(), F.begin()->getFirstInsertionPt());
  if (DISubprogram *SP = F.getSubprogram())
    IRB.SetCurrentDebugLocation(DebugLoc::get(SP->getScopeLine(), 0, SP));
  ///
  std::vector<Type *> arg_type;
  std::vector<Value *> args;
  LLVMContext &C = F.getContext();
  MDNode *N = MDNode::get(C, {MDString::get(C, "r15")});
  arg_type.push_back(Type::getInt64Ty(C));
  Function *readRegisterFunc = Intrinsic::getDeclaration(
      F.getParent(), Intrinsic::read_register, arg_type);
  args.push_back(MetadataAsValue::get(C, N));

  ///
  //  FunctionCallee Fn = F.getParent()->getOrInsertFunction(
  //      EXTERN_STACK_OBJECTS_PTR_CALL, StackPtrTy->getPointerTo(0));
  Value *savedStackPtr = IRB.CreateCall(readRegisterFunc, args);
  Type *int64Ptr = Type::getInt64PtrTy(C);
  Value *intToPtr = IRB.CreateIntToPtr(savedStackPtr, int64Ptr);
  intToPtr = IRB.CreateBitCast(intToPtr, int64Ptr->getPointerTo(0));
  this->ExternStackPtr =
      IRB.CreateBitCast(intToPtr, StackPtrTy->getPointerTo(0));
  Instruction *BasePtr =
      IRB.CreateLoad(StackPtrTy, ExternStackPtr, false, "extern_stack_ptr");
  assert(BasePtr->getType() == StackPtrTy);

  Value *StaticTop =
      moveStaticAllocasToExternStack(IRB, F, StaticAllocas, BasePtr);
  AllocaInst *DynamicTop = createStackRestorePoints(
      IRB, F, StackRestorePoints, StaticTop, !DynamicAllocas.empty());

  moveDynamicAllocasToExternStack(F, ExternStackPtr, DynamicTop,
                                  DynamicAllocas);

  for (ReturnInst *RI : Returns) {
    IRB.SetInsertPoint(RI);
    IRB.CreateStore(BasePtr, ExternStackPtr);
  }
}

class MpkIsolationGatesPass : public FunctionPass {
public:
  static char ID;
  MpkIsolationGatesPass() : FunctionPass(ID) {
    initializeMpkIsolationGatesPassPass(*PassRegistry::getPassRegistry());
    domain = nullptr;
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<TargetPassConfig>();
    AU.addRequired<TargetLibraryInfoWrapperPass>();
    AU.addRequired<AssumptionCacheTracker>();
  }

  bool runOnFunction(Function &) override;

private:
  void applySFICast(StoreInst *);
  void applySFIGEPCheck(GetElementPtrInst *);
  void applySFIMEMIntrinsicCheck(IntrinsicInst *);
  void applyFalsePositiveCheck(Instruction *);
  void applyFalseNegativeCheck(Instruction *);
  void insertExternStackCall();
  Function *createFunction(std::string, FunctionType *, Module *);
  MpkDomain *domain;
  Instruction *currCallSite;
  DataLayout *dataLayout;
  Function *currFunction;
  MPKExternStack *externStack;
  TargetMachine *TM = nullptr;
};

void MpkIsolationGatesPass::applyFalseNegativeCheck(Instruction *inst) {
  assert((isa<StoreInst>(inst) || isa<LoadInst>(inst)) &&
         "Checking false negative on non-memory instruction?");
  IRBuilder<> IRB(inst);
  auto &cxt = inst->getContext();
  auto module = inst->getModule();
  FunctionType *voidTyPtrArg =
      FunctionType::get(Type::getVoidTy(cxt), Type::getInt8PtrTy(cxt), false);
  FunctionCallee callee = module->getOrInsertFunction(
      isa<StoreInst>(inst) ? STORE_FALSE_NEGATIVE_CHECK_FUNC_NAME
                           : LOAD_FALSE_NEGATIVE_CHECK_FUNC_NAME,
      voidTyPtrArg);
  SmallVector<Value *, 4> Args;
  Value *pointer = llvm::isa<StoreInst>(inst)
                       ? (llvm::cast<StoreInst>(inst))->getPointerOperand()
                       : (llvm::cast<LoadInst>(inst))->getPointerOperand();
  auto cast = IRB.CreateBitCast(pointer, Type::getInt8PtrTy(cxt));
  Args.push_back(cast);
  IRB.CreateCall(callee, Args);
}
void MpkIsolationGatesPass::applyFalsePositiveCheck(Instruction *inst) {
  assert((isa<LoadInst>(inst) || isa<StoreInst>(inst)) &&
         "Checking false positive on non-memory instruction?");
  IRBuilder<> IRB(inst);
  auto &cxt = inst->getContext();
  auto module = inst->getModule();
  FunctionType *voidTyPtrArg =
      FunctionType::get(Type::getVoidTy(cxt), Type::getInt8PtrTy(cxt), false);
  FunctionCallee callee = module->getOrInsertFunction(
      isa<StoreInst>(inst) ? STORE_FALSE_POSITIVE_CHECK_FUNC_NAME
                           : LOAD_FALSE_POSITIVE_CHECK_FUNC_NAME,
      voidTyPtrArg);
  SmallVector<Value *, 4> Args;
  Value *pointer = isa<StoreInst>(inst)
                       ? (llvm::cast<StoreInst>(inst))->getPointerOperand()
                       : (llvm::cast<LoadInst>(inst))->getPointerOperand();
  auto cast = IRB.CreateBitCast(pointer, Type::getInt8PtrTy(cxt));
  Args.push_back(cast);
  IRB.CreateCall(callee, Args);
}

void MpkIsolationGatesPass::applySFIGEPCheck(GetElementPtrInst *gep) {
  auto &cxt = gep->getContext();
  Instruction *next = gep->getNextNode();
  IRBuilder<> builder(next);
  auto gepPtr = gep->getPointerOperand();
  auto unsafeBound = ConstantInt::get(Type::getInt64Ty(cxt), 0);
  auto gepPtr2Int = builder.CreatePtrToInt(gepPtr, Type::getInt64Ty(cxt));
  auto cmp = builder.CreateCmp(CmpInst::ICMP_ULT, gepPtr2Int, unsafeBound);
  auto gep2Int = builder.CreatePtrToInt(gep, Type::getInt64Ty(cxt));
  auto cmp2 = builder.CreateCmp(CmpInst::ICMP_ULT, gep2Int, unsafeBound);
  auto binaryAND = builder.CreateBinOp(Instruction::BinaryOps::And, cmp, cmp2);
  auto fullCmp = builder.CreateCmp(CmpInst::ICMP_EQ, binaryAND,
                                   ConstantInt::get(Type::getInt1Ty(cxt), 1));
  Instruction *thenInst, *elseInst;
  SplitBlockAndInsertIfThenElse(fullCmp, next, &thenInst, &elseInst);
  builder.SetInsertPoint(elseInst);
  builder.CreateCall(domain->getSFIExceptionFunc());
}

void MpkIsolationGatesPass::applySFICast(StoreInst *store) {
  auto &cxt = store->getContext();
  IRBuilder<> builder(store);
  auto andConst = ConstantInt::get(Type::getInt64Ty(cxt), -1);
  auto ptr = store->getPointerOperand();
  auto ptr2Int = builder.CreatePtrToInt(ptr, Type::getInt64Ty(cxt));
  auto SFIAND = builder.CreateBinOp(Instruction::And, ptr2Int, andConst);
  auto intToPtr = builder.CreateIntToPtr(SFIAND, Type::getInt8PtrTy(cxt));
  auto bitCast = builder.CreateBitCast(intToPtr, ptr->getType());
  store->setOperand(1, bitCast);
}

Function *MpkIsolationGatesPass::createFunction(std::string name,
                                                FunctionType *type, Module *M) {
  FunctionCallee callee = M->getOrInsertFunction(name, type);
  return dyn_cast<Function>(callee.getCallee());
}

bool MpkIsolationGatesPass::runOnFunction(Function &F) {
  if (!llvm::shouldHookWithMpkIsolation() || F.isDeclaration())
    return false;

  currFunction = &F;
  auto &currContext = F.getContext();
  Module *currModule = F.getParent();
  dataLayout = new DataLayout(currModule);
  TM = &getAnalysis<TargetPassConfig>().getTM<TargetMachine>();
  auto *TL = TM->getSubtargetImpl(F)->getTargetLowering();
  if (!TL)
    report_fatal_error("TargetLowering instance is required");

  auto *DL = &F.getParent()->getDataLayout();
  auto &TLI = getAnalysis<TargetLibraryInfoWrapperPass>().getTLI(F);
  auto &ACT = getAnalysis<AssumptionCacheTracker>().getAssumptionCache(F);
  if (!DL)
    report_fatal_error("Data Layout is required");
  DominatorTree DT(F);
  LoopInfo LI(DT);
  ScalarEvolution SE(F, TLI, ACT, DT, LI);
  externStack = new MPKExternStack(F, *TL, *DL, SE);

  if (!domain) {
    // initialize domain
    domain = new MpkDomain();
    FunctionType *voidType =
        FunctionType::get(Type::getVoidTy(currContext), {}, false);
    FunctionType *ptrRetVoidArgType =
        FunctionType::get(Type::getInt64PtrTy(currContext), {}, false);
    FunctionType *void2IntArgType = FunctionType::get(
        Type::getVoidTy(currContext),
        {Type::getInt8Ty(currContext), Type::getInt8Ty(currContext)}, false);
    domain->setSFIExceptionFunc(
        createFunction(SFI_EXCEPTION_FUNC_NAME, voidType, currModule));
    domain->setCountAllocasFunc(
        createFunction(COUNT_ALLOCA_FUNC_NAME, void2IntArgType, currModule));
  }
  SmallVector<AllocaInst *, 4> StaticArrayAllocas;
  SmallVector<AllocaInst *, 4> DynamicArrayAllocas;
  SmallVector<Instruction *, 8> StackRestorePoints;
  SmallVector<ReturnInst *, 4> Returns;
  SmallVector<Instruction *, 8> ExternCalls;
  bool foundMovable = false;
  if (F.getName() == "main") {
    auto II = F.begin()->begin();
    Instruction *inst = &(*II);
    IRBuilder<> IRB(inst);
    Type *StackPtrTy = Type::getInt8PtrTy(F.getContext());
    FunctionCallee Fn = F.getParent()->getOrInsertFunction(
        GET_DOMAIN_FUNC_NAME, StackPtrTy->getPointerTo(0));
    Value *ExternStackPtr = IRB.CreateCall(Fn);

    std::vector<Type *> arg_type;
    std::vector<Value *> args;
    LLVMContext &C = F.getContext();
    Type *int64PtrTy = Type::getInt64Ty(C);
    MDNode *N = MDNode::get(C, {MDString::get(C, "r15")});
    arg_type.push_back(int64PtrTy);
    Function *writeRegisterFunc = Intrinsic::getDeclaration(
        F.getParent(), Intrinsic::write_register, arg_type);

    Value *ptrToIntInst = IRB.CreatePtrToInt(ExternStackPtr, int64PtrTy);

    args.push_back(MetadataAsValue::get(C, N));
    args.push_back(ptrToIntInst);

    IRB.CreateCall(writeRegisterFunc, args);
    return true;
  }

  size_t totalAllocas = 0;
  size_t totalUnsafeAllocas = 0;
  for (auto &BB : F) {
    for (BasicBlock::iterator I = BB.begin(); I != BB.end(); ++I) {
      Instruction *currInst = &(*I);
      if (auto CI = dyn_cast<CallInst>(currInst)) {
        if (CI->getCalledFunction() && CI->canReturnTwice()) {
          StackRestorePoints.push_back(CI);
        }
      } else if (auto LP = dyn_cast<LandingPadInst>(currInst)) {
        StackRestorePoints.push_back(LP);
      } else if (auto allocaInst = dyn_cast<AllocaInst>(currInst)) {
        if (allocaInst->hasMetadata("MPK-Extern-Move")) {
          if (allocaInst->isStaticAlloca()) {
            if (std::find(StaticArrayAllocas.begin(), StaticArrayAllocas.end(),
                          allocaInst) == StaticArrayAllocas.end()) {
              StaticArrayAllocas.push_back(allocaInst);
              foundMovable = true;
            }
          } else {
            if (std::find(DynamicArrayAllocas.begin(),
                          DynamicArrayAllocas.end(),
                          allocaInst) == DynamicArrayAllocas.end()) {
              DynamicArrayAllocas.push_back(allocaInst);
              foundMovable = true;
            }
          }
          totalUnsafeAllocas++;
        }
        totalAllocas++;
      } else if (auto returnInst = dyn_cast<ReturnInst>(currInst)) {
        Returns.push_back(returnInst);
      } else if (isa<StoreInst>(currInst) || isa<LoadInst>(currInst)) {

        if (currInst->getMetadata("MPK-Unsafe") != nullptr) {
          if (auto storeInst = llvm::dyn_cast<StoreInst>(currInst)) {
            applySFICast(storeInst);
          }
          // applyFalsePositiveCheck(currInst);
        }else{
          // applyFalseNegativeCheck(currInst);
        }
      }
      /*else if(auto gepInst = dyn_cast<GetElementPtrInst>(currInst)){
        if(gepInst->getMetadata("POSSIBLE-Unsafe") != nullptr){
          applySFIGEPCheck(gepInst);
        }
      }*/
      if (MpkDomain::shouldInstrumentInstruction(currInst)) {
        MDNode *N = MDNode::get(currContext,
                                MDString::get(currContext, "wrap-ffi-call"));
        currInst->setMetadata("ADD-FFI-WRAPPER", N);
        // ExternCalls.push_back(currInst);
        MDNode *NN =
            MDNode::get(currContext, MDString::get(currContext, "TRUE"));
        F.addMetadata("HAS_EXTERN_CALLS", *NN);
      }
    }
  }

  if(totalAllocas > 0){
    Instruction* beginInst = &(*(F.begin()->begin()));
    IRBuilder<> IRB(beginInst);
    // IRB.CreateCall(domain->getCountAllocasFunc(),{ConstantInt::get(Type::getInt8Ty(currContext),totalAllocas),ConstantInt::get(Type::getInt8Ty(currContext),totalUnsafeAllocas)});
  }

  if (foundMovable) {
    externStack->run(StaticArrayAllocas, DynamicArrayAllocas,
                     StackRestorePoints, Returns);
  }
  return !ExternCalls.empty() || foundMovable;
}

char MpkIsolationGatesPass::ID = 0;
INITIALIZE_PASS_BEGIN(MpkIsolationGatesPass, "mpk-isolation-gates",
                      "Mpk Isolation gates Pass", false, false)
INITIALIZE_PASS_END(MpkIsolationGatesPass, "mpk-isolation-gates",
                    "Mpk Isolation gates pass", false, false)
FunctionPass *llvm::createMpkIsolationGatesPass() {
  return new MpkIsolationGatesPass();
}
