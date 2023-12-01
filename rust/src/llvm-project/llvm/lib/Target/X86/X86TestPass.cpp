//#include "x86.h"
// #include "ARMBaseInstrInfo.h"
// #include "ARMBaseRegisterInfo.h"
// #include "ARMISelLowering.h"
// #include "ARMMachineFunctionInfo.h"
#include "X86Subtarget.h"
#include "X86.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/CodeGen/Passes.h"

// #include "MCTargetDesc/ARMAddressingModes.h"
// #include "ThumbRegisterInfo.h"
 #include "llvm/ADT/DenseMap.h"
 #include "llvm/ADT/STLExtras.h"
 #include "llvm/ADT/SmallPtrSet.h"
 #include "llvm/ADT/SmallSet.h"
 #include "llvm/ADT/SmallVector.h"
 #include "llvm/ADT/Statistic.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
 #include "llvm/CodeGen/MachineRegisterInfo.h"
 #include "llvm/CodeGen/RegisterClassInfo.h"
 #include "llvm/CodeGen/SelectionDAGNodes.h"
 #include "llvm/CodeGen/LivePhysRegs.h"
 #include "llvm/IR/DataLayout.h"
 #include "llvm/IR/DerivedTypes.h"
 #include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
 #include "llvm/Support/Allocator.h"
 #include "llvm/Support/Debug.h"
 #include "llvm/Support/ErrorHandling.h"
 #include "llvm/Support/raw_ostream.h"
// #include "llvm/Target/TargetInstrInfo.h"
 #include "llvm/CodeGen/TargetInstrInfo.h"
 #include "llvm/Target/TargetMachine.h"
 #include "llvm/CodeGen/TargetRegisterInfo.h"

#include "llvm/Transforms/MpkIsolation.h"

using namespace llvm;

#define DEBUG_TYPE "x86-testpass"

// namespace llvm {
//   void initializeX86TestPassPass(PassRegistry &);
// }

#define X86_TESTPASS_NAME                                       \
    "X86 test pass"

/*
MachineInstr::memoperands()
MachineMemOperand::getAddrSpace()
*/
namespace {
  extern bool shouldHookWithMpkIsolation();
  
  struct X86TestPass : public MachineFunctionPass{
    static char ID;
    X86TestPass() : MachineFunctionPass(ID) {
      initializeX86TestPassPass(*PassRegistry::getPassRegistry());
    }

    // const DataLayout *TD;
    const TargetInstrInfo *TII;
    // const TargetRegisterInfo *TRI;
    const TargetSubtargetInfo *STI;
    // MachineRegisterInfo *MRI;
    // MachineFunction *MF;

    bool runOnMachineFunction(MachineFunction &Fn) override;

    //    const char *getPassName() const override {
    StringRef getPassName() const override {
      return X86_TESTPASS_NAME;
    }

  };
}
  char X86TestPass::ID = 0;


INITIALIZE_PASS(X86TestPass, "x86-testpass",
                X86_TESTPASS_NAME, false, false)

/// Returns true if instruction is a memory operation that this pass is capable
/// of operating on.
static bool isMemoryOp(const MachineInstr &MI) {
  unsigned Opcode = MI.getOpcode();
  //errs()<<"iyb:\n";
  switch (Opcode) {
  // case X86::LDS32r:
  // case X86::LDS64_32r:
  // case X86::LDS64r:
  case X86::LEA16r:
  case X86::LEA32r:
  case X86::LEA64_32r:
  case X86::LEA64r:
  // case X86::LES32r:
  // case X86::LES64_32r:
  // case X86::LES64r:
  // case X86::LODSB32r:
  // case X86::LODSB64_32r:
  // case X86::LODSB64r:
  // case X86::LODSW32r:
  // case X86::LODSW64_32r:
  // case X86::LODSW64r:
  // case X86::LFS32r:
  // case X86::LFS64_32r:
  // case X86::LFS64r:
  // case X86::LGS32r:
  // case X86::LGS64_32r:
  // case X86::LGS64r:
  // case X86::LODSD32r:
  // case X86::LODSD64_32r:
  // case X86::LODSD64r:
  // case X86::LODSQ32r:
  // case X86::LODSQ64_32r:
  // case X86::LODSQ64r:
    break;
  default:
    return false;
  }
  // if (!MI.getOperand(1).isReg())
  //   return false;

  // // When no memory operands are present, conservatively assume unaligned,
  // // volatile, unfoldable.
  if (!MI.hasOneMemOperand())
    return false;

  const MachineMemOperand &MMO = **MI.memoperands_begin();

  // Don't touch volatile memory accesses - we may be changing their order.
  if (MMO.isVolatile())
    return false;

  // Unaligned ldr/str is emulated by some kernels, but unaligned ldm/stm is
  // not.
  if (MMO.getAlignment() < 4)
    return false;

  // // str <undef> could probably be eliminated entirely, but for now we just want
  // // to avoid making a mess of it.
  // // FIXME: Use str <undef> as a wildcard to enable better stm folding.
  if (MI.getOperand(0).isReg() && MI.getOperand(0).isUndef())
    return false;

  // // Likewise don't mess with references to undefined addresses.
  if (MI.getOperand(1).isUndef())
    return false;

  return true;
}

bool X86TestPass::runOnMachineFunction(MachineFunction &Fn) {
  if(!llvm::shouldHookWithMpkIsolation()){
    return false;
  }
  // TD = &Fn.getDataLayout();
  STI = &static_cast<const TargetSubtargetInfo&>(Fn.getSubtarget());
  TII = STI->getInstrInfo();
  // TRI = STI->getRegisterInfo();
  // MRI = &Fn.getRegInfo();
  // MF  = &Fn;

  errs() <<"iyb:machineFunctionPass\n";
  bool Modified = false;
  for (MachineBasicBlock &MFI : Fn) {
    for (MachineInstr &MI : MFI) {
      if (!isMemoryOp(MI))
	continue;
      unsigned Reg = MI.getOperand(0).getReg();

      MachineInstr * Instr = BuildMI(MFI, MI, MI.getDebugLoc(), TII->get(X86::MOV64rr), Reg).addReg(Reg);
      MFI.insertAfter(MI, Instr);
      errs() << "IYB: inserting mov: "
	     << Instr->getOpcode()
	     << "\n";
      //      dbgs() << "  IYB: inserting mov: " << Instr->dump()   << "\n";
      //      MI.insertAfter(&MI);
      //      &MFI->getInstList().insert(&MI,&MI);
      // AddDefaultPred(BuildMI(MFI, MI, MI.getDebugLoc(), TII->get(ARM::t2ADDri), Reg)
      //                .addReg(Reg).addImm(0));
    }
  }
  // Modified |= RescheduleLoadStoreInstrs(&MFI);
  return Modified;
}

FunctionPass *llvm::createX86TestPassPass() {
  return new X86TestPass();
}
