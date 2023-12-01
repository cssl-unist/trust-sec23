#ifndef _MPK_RUST_ISOLATION_H
#define _MPK_RUST_ISOLATION_H

#include "RustDemangle.h"
#include "Util/DPItem.h"
#include "Util/Options.h"
#include "MemoryModel/PointerAnalysisImpl.h"
#include "DDA/DDAPass.h"
#include "DDA/FlowDDA.h"
#include "DDA/ContextDDA.h"
#include "DDA/DDAClient.h"
#include "SVF-FE/PAGBuilder.h"
#include "llvm/Transforms/Utils/Cloning.h"

using namespace SVF;
const string RUST_LIBRARIES [] = {
        "alloc",
        "core",
        "std",
        "backtrace",
        "stdarch",
        "term",
        "rtstartup",
        "unwind",
        "libc",
        "cfg_if",
        "getrandom",
        "libm",
        "num_traits",
        "ppv_lite86",
        "proc_macro2",
        "proc_macro",
        "quote",
        "rand",
        "rand_chacha",
        "rand_core",
        "rand_distr",
        "rand_pcg",
        "serde",
        "serde_derive",
        "syn",
        "unicode_xid",
        "clap",
};
extern set<const Function*> RustLibraryFunctions;

static bool isRustLibraryFunc(const Function* func){
    return RustLibraryFunctions.find(func) != RustLibraryFunctions.end();
}
static bool isRustLibraryFunc(string FuncName){
    if(FuncName.empty() || !FuncName.length())
        return false;
    string orig = FuncName;
    while(FuncName.length() > 1 && !isalpha(FuncName[0])){
        FuncName = FuncName.substr(1);
    }
    for(auto lib: RUST_LIBRARIES){
        string compare = lib+"::";
        if(!strncmp(compare.c_str(), FuncName.c_str(), compare.length())){
            return true;
        }

        if(FuncName.find(" as "+compare,0) != std::string::npos){
            return true;
        }
    }
    std::cout<<FuncName<<std::endl;
    return false;
}

static void strapUnsafeMarks(Function &F){
    for(auto& BB: F){
        for(llvm::BasicBlock::iterator I = BB.begin(), E = BB.end(); I != E; ++I){
            Instruction *inst = &(*I);
            if(inst->getMetadata("MPK-Unsafe") != nullptr){
                inst->setMetadata("MPK-Unsafe", nullptr);
            }
        }
    }
}

static void strapAndMarkRustStdLibraries(Module& M){
    char* demangle_buff = (char*) malloc(256);
    memset(demangle_buff,0,256);
    string changedPrefix = "__mpk_struct_ret_trans_";
    ///Mark Rust Library Functions and strap them of unsafety
    for(auto& F: M){
        if(F.isDeclaration())
            continue;
        string FuncName = F.getName().str();
        if(FuncName.rfind(changedPrefix) == 0){
            FuncName = FuncName.substr(changedPrefix.length());
        }

        int demangle_result = demangle_func_name((char *) FuncName.c_str(), demangle_buff, 256);
        if (!demangle_result && isRustLibraryFunc(demangle_buff)) {
            strapUnsafeMarks(F);
            RustLibraryFunctions.insert(&F);
        }
        memset(demangle_buff,0,256);
    }
    free(demangle_buff);
}

/*
class MPKRustIsolation{
    const string RUST_LIBRARIES [] = {
        "alloc",
        "core",
        "std",
        "backtrace",
        "stdarch",
        "term",
        "rtstartup",
        "unwind",
        "libc",
        "cfg_if",
        "getrandom",
        "libm",
        "num_traits",
        "ppv_lite86",
        "proc_macro2",
        "quote",
        "rand",
        "rand_chacha",
        "rand_core",
        "rand_distr",
        "rand_pcg",
        "serde",
        "serde_derive",
        "syn",
        "unicode_xid",
    };

private:
    SVFG* svfg;
    PAG* pag;
    PTACallGraph* callGraph;

    public:
    MPKRustIsolation()
    static bool isRustLibraryFunc(string FuncName);
    static bool isRustLibraryFunc(Function* func);
};
*/
#endif