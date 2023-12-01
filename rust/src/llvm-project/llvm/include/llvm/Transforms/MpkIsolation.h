#ifndef LLVM_MPK_ISOLATION_H
#define LLVM_MPK_ISOLATION_H

#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/InitializePasses.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/IR/AbstractCallSite.h"
#include <llvm/IR/Constants.h>
#include <llvm/IR/DataLayout.h>
#include <llvm/IR/Instructions.h>

#define SFI_EXCEPTION_FUNC_NAME "__sfi_exception"
#define GET_DOMAIN_FUNC_NAME "__get_domain_ptr"
#define FALSE_POSITIVE_CHECK_FUNC_NAME "__check_false_positive"
#define COUNT_ALLOCA_FUNC_NAME  "__count_allocas"
namespace llvm {
  bool shouldHookWithMpkIsolation();

  class MpkDomain{
    Function* sfiExceptionFunc;
    Function* countAllocasFunc;

    public:
    MpkDomain(){
      sfiExceptionFunc = nullptr;
      countAllocasFunc = nullptr;
    }

    ~MpkDomain(){
      if(sfiExceptionFunc) delete sfiExceptionFunc;
      if(countAllocasFunc) delete countAllocasFunc;
    }

    void setCountAllocasFunc(Function* func){
      this->countAllocasFunc = func;
    }

    Function* getCountAllocasFunc(){
      return this->countAllocasFunc;
    }

    void setSFIExceptionFunc(Function* func){
      this->sfiExceptionFunc = func;
    }

    Function* getSFIExceptionFunc(){
      return sfiExceptionFunc;
    }

    static bool shouldInstrumentInstruction(Instruction* inst){
      if(CallBase* CB = dyn_cast<CallBase>(inst)){
          if(CB->getCalledFunction() && CB->getCalledFunction()->getName() == "main")
              return false;
        return CB->hasFnAttr(Attribute::MPKExtern) && !CB->isInlineAsm();
      }
      return false;
    }

    static bool shouldInstrumentFFICall(const CallBase* CB){
      if(CB != nullptr && CB->getMetadata("ADD-FFI-WRAPPER") != nullptr){
        Function* calledFunc = CB->getCalledFunction();
        return calledFunc->isDeclaration() && !calledFunc->getName().equals("rust_eh_personality");
      }
      return false;
    }
  };
}

#endif
