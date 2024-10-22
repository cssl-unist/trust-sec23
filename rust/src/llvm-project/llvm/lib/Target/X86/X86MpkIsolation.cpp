//
// Created by martin on 5/17/21.
//
#include "X86.h"
#include "llvm/Transforms/MpkIsolation.h"
#include "llvm/IR/AbstractCallSite.h"
#include "X86InstrBuilder.h"
#include "X86InstrInfo.h"
#include "X86MachineFunctionInfo.h"
#include "X86Subtarget.h"
#include "X86TargetMachine.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/Analysis/EHPersonalities.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/WinEHFuncInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Function.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Support/Debug.h"
#include "llvm/Target/TargetOptions.h"
#include "llvm/Support/Alignment.h"
#include "llvm/Support/CommandLine.h"

using namespace llvm;

#define X86_MPK_ISOLATION_NAME "X86 MPK Isolation"

namespace {
static cl::opt<bool> EnableTrustMpk(
    "trust-enable-mpk", cl::init(false), cl::Hidden,
    cl::desc("Enable real MPK protection"));
class X86MPKIsolation: public MachineFunctionPass {
  enum MPKPROT{
    ProtRWX = 0b00,
    ProtRX = 0b10,
    ProtX = 0b11
  };
  const uint32_t MPK_MASK = 0xFFFFFFFF;
public:
  static char ID;
  X86MPKIsolation(): MachineFunctionPass(ID){
    initializeX86MPKIsolationPass(*PassRegistry::getPassRegistry());
  }
  bool runOnMachineFunction(MachineFunction &MF) override;
  bool isExternCall(MachineInstr &MI);
  bool isFrameStoreOpcode(int Opcode, unsigned &MemBytes);
  bool isPush(int Opcode, unsigned &MemBytes);
  const uint32_t getMaskedPKRU(uint8_t pKey, const MPKPROT& prot);
};

}


bool X86MPKIsolation::isPush(int Opcode, unsigned &MemBytes){

    // Currently handle only PUSHes we can reasonably expect to see
    // in call sequences
    switch (Opcode) {
        case X86::PUSH32i8:
        case X86::PUSH32r:
        case X86::PUSH32rmm:
        case X86::PUSH32rmr:
        case X86::PUSHi32:
            MemBytes = 4;
            return true;
        case X86::PUSH64i8:
        case X86::PUSH64r:
        case X86::PUSH64rmm:
        case X86::PUSH64rmr:
        case X86::PUSH64i32:
            MemBytes = 8;
            return true;
        default:
            return false;
    }
}

bool X86MPKIsolation::isFrameStoreOpcode(int Opcode, unsigned &MemBytes) {
  switch (Opcode) {
  default:
    return false;
  case X86::MOV8mr:
  case X86::KMOVBmk:
    MemBytes = 1;
    return true;
  case X86::MOV16mr:
  case X86::KMOVWmk:
    MemBytes = 2;
    return true;
  case X86::MOV32mr:
  case X86::MOVSSmr:
  case X86::VMOVSSmr:
  case X86::VMOVSSZmr:
  case X86::KMOVDmk:
    MemBytes = 4;
    return true;
  case X86::MOV64mr:
  case X86::ST_FpP64m:
  case X86::MOVSDmr:
  case X86::VMOVSDmr:
  case X86::VMOVSDZmr:
  case X86::MMX_MOVD64mr:
  case X86::MMX_MOVQ64mr:
  case X86::MMX_MOVNTQmr:
  case X86::KMOVQmk:
    MemBytes = 8;
    return true;
  case X86::MOVAPSmr:
  case X86::MOVUPSmr:
  case X86::MOVAPDmr:
  case X86::MOVUPDmr:
  case X86::MOVDQAmr:
  case X86::MOVDQUmr:
  case X86::VMOVAPSmr:
  case X86::VMOVUPSmr:
  case X86::VMOVAPDmr:
  case X86::VMOVUPDmr:
  case X86::VMOVDQAmr:
  case X86::VMOVDQUmr:
  case X86::VMOVUPSZ128mr:
  case X86::VMOVAPSZ128mr:
  case X86::VMOVUPSZ128mr_NOVLX:
  case X86::VMOVAPSZ128mr_NOVLX:
  case X86::VMOVUPDZ128mr:
  case X86::VMOVAPDZ128mr:
  case X86::VMOVDQA32Z128mr:
  case X86::VMOVDQU32Z128mr:
  case X86::VMOVDQA64Z128mr:
  case X86::VMOVDQU64Z128mr:
  case X86::VMOVDQU8Z128mr:
  case X86::VMOVDQU16Z128mr:
    MemBytes = 16;
    return true;
  case X86::VMOVUPSYmr:
  case X86::VMOVAPSYmr:
  case X86::VMOVUPDYmr:
  case X86::VMOVAPDYmr:
  case X86::VMOVDQUYmr:
  case X86::VMOVDQAYmr:
  case X86::VMOVUPSZ256mr:
  case X86::VMOVAPSZ256mr:
  case X86::VMOVUPSZ256mr_NOVLX:
  case X86::VMOVAPSZ256mr_NOVLX:
  case X86::VMOVUPDZ256mr:
  case X86::VMOVAPDZ256mr:
  case X86::VMOVDQU8Z256mr:
  case X86::VMOVDQU16Z256mr:
  case X86::VMOVDQA32Z256mr:
  case X86::VMOVDQU32Z256mr:
  case X86::VMOVDQA64Z256mr:
  case X86::VMOVDQU64Z256mr:
    MemBytes = 32;
    return true;
  case X86::VMOVUPSZmr:
  case X86::VMOVAPSZmr:
  case X86::VMOVUPDZmr:
  case X86::VMOVAPDZmr:
  case X86::VMOVDQU8Zmr:
  case X86::VMOVDQU16Zmr:
  case X86::VMOVDQA32Zmr:
  case X86::VMOVDQU32Zmr:
  case X86::VMOVDQA64Zmr:
  case X86::VMOVDQU64Zmr:
    MemBytes = 64;
    return true;
  }
  return false;
}

bool X86MPKIsolation::isExternCall(MachineInstr &MI) {
  if (MI.getDesc().isCall()){
    for(auto& MO: MI.operands()){
      if(MO.isGlobal()){
        auto Global = MO.getGlobal();
        if(Global->getValueType()->isFunctionTy()){
          Function* calledFunc = Global->getParent()->getFunction(Global->getName());
          return calledFunc->hasFnAttribute(Attribute::MPKExtern);
        }
      }
    }
  }
  return false;
}

char X86MPKIsolation::ID = 0;

bool X86MPKIsolation::runOnMachineFunction(MachineFunction &MF) {
  Function* llFunction = &MF.getFunction();
    if(!llFunction->hasMetadata("HAS_EXTERN_CALLS"))
        return false;
        
  bool foundEntry = false;
  const TargetSubtargetInfo* TSI = &static_cast<const TargetSubtargetInfo&>(MF.getSubtarget());
  const TargetInstrInfo* TII = TSI->getInstrInfo();
  for(auto &BB: MF){
    MachineBasicBlock::iterator MI = BB.begin();
    while(MI != BB.end()){
      if(MI->getDesc().isCall() && isExternCall(*MI)){
        auto DL = MI->getDebugLoc();

        /// Store Stack Ptr
        auto saveRSP = BuildMI(BB, MI, DL, TII->get(X86::MOV64mr));
        addRegOffset(saveRSP, X86::R15, false, 24).addReg(X86::RSP);

        /// Get Extern Stack Ptr
        auto getRSP = BuildMI(BB, MI, DL, TII->get(X86::MOV64rm), X86::RAX);
        addRegOffset(getRSP, X86::R15, false, 0);

        /// Switch Stack ptr
        BuildMI(BB, MI, DL, TII->get(X86::MOV64rr), X86::RSP).addReg(X86::RAX);

        /// Switch Domain for MPK-LIBRARY
        auto switchDomain = BuildMI(BB, MI, DL, TII->get(X86::MOV32mi));
        addRegOffset(switchDomain, X86::R15, false, 8).addImm(1);

        /// Switch Domain for MPK
        auto saveEDX = BuildMI(BB, MI, DL, TII->get(X86::MOV32mr));
        addRegOffset(saveEDX, X86::R15, false, 16).addReg(X86::EDX);
        auto saveECX = BuildMI(BB, MI, DL, TII->get(X86::MOV32mr));
        addRegOffset(saveECX, X86::R15, false, 20).addReg(X86::ECX);
        BuildMI(BB, MI, DL, TII->get(X86::MOV32ri), X86::ECX).addImm(0);
        BuildMI(BB, MI, DL, TII->get(X86::MOV32ri), X86::EDX).addImm(0);
	BuildMI(BB, MI, DL, TII->get(X86::RDPKRUr));
	BuildMI(BB, MI, DL, TII->get(X86::OR32ri), X86::EAX).addImm(EnableTrustMpk? 2: 0);
        //BuildMI(BB, MI, DL, TII->get(X86::MOV32ri), X86::EAX).addImm(2);
        BuildMI(BB, MI, DL, TII->get(X86::WRPKRUr));
        auto restoreEDX = BuildMI(BB, MI, DL, TII->get(X86::MOV32rm), X86::EDX);
        addRegOffset(restoreEDX, X86::R15, false, 16);
        auto restoreECX = BuildMI(BB, MI, DL, TII->get(X86::MOV32rm), X86::ECX);
        addRegOffset(restoreECX, X86::R15, false, 20);
        MI++;

        /// Switch Domain for MPK
        auto saveEAX = BuildMI(BB, MI, DL, TII->get(X86::MOV32mr));
        addRegOffset(saveEAX, X86::R15, false, 12).addReg(X86::EAX);
        saveEDX = BuildMI(BB, MI, DL, TII->get(X86::MOV32mr));
        addRegOffset(saveEDX, X86::R15, false, 16).addReg(X86::EDX);
        saveECX = BuildMI(BB, MI, DL, TII->get(X86::MOV32mr));
        addRegOffset(saveECX, X86::R15, false, 20).addReg(X86::ECX);
        BuildMI(BB, MI, DL, TII->get(X86::MOV32ri), X86::ECX).addImm(0);
        BuildMI(BB, MI, DL, TII->get(X86::MOV32ri), X86::EDX).addImm(0);
	BuildMI(BB, MI, DL, TII->get(X86::RDPKRUr));
	BuildMI(BB, MI, DL, TII->get(X86::AND8ri), X86::AL).addImm(0xF0);
        //BuildMI(BB, MI, DL, TII->get(X86::MOV32ri), X86::EAX).addImm(0);
        BuildMI(BB, MI, DL, TII->get(X86::WRPKRUr));

        auto restoreEAX = BuildMI(BB, MI, DL, TII->get(X86::MOV32rm), X86::EAX);
        addRegOffset(restoreEAX, X86::R15, false, 12);
        restoreEDX = BuildMI(BB, MI, DL, TII->get(X86::MOV32rm), X86::EDX);
        addRegOffset(restoreEDX, X86::R15, false, 16);
        restoreECX = BuildMI(BB, MI, DL, TII->get(X86::MOV32rm), X86::ECX);
        addRegOffset(restoreECX, X86::R15, false, 20);

        /// Switch Domain for MPK-LIBRARY
        switchDomain = BuildMI(BB, MI, DL, TII->get(X86::MOV32mi));
        addRegOffset(switchDomain, X86::R15, false, 8).addImm(0);

        /// Restore StackPtr
        auto restoreRSP = BuildMI(BB, MI, DL, TII->get(X86::MOV64rm), X86::RSP);
        addRegOffset(restoreRSP, X86::R15, false, 24);
        MI--;
      }
      MI++;
    }
  }
  return true;
}

INITIALIZE_PASS(X86MPKIsolation, "x86-mpk-isolation-pass",
                X86_MPK_ISOLATION_NAME, false, false
)
FunctionPass *llvm::createX86MPKIsolationPass(){
  return new X86MPKIsolation();
}

