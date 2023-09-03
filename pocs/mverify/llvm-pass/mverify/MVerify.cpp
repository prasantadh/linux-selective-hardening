#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Config/llvm-config.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {

void visitor(Function &F) {
    errs() << "(mverify) Hello from: " << F.getName() << "\n";
    errs() << "(mverify)   number of arguments: " << F.arg_size() << "\n";
}

struct MVerify : PassInfoMixin<MVerify> {

    PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
        visitor(F);
        return PreservedAnalyses::all();
    }

    static bool isRequired() { return true; }
};

}

PassPluginLibraryInfo getMVerifyPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "MVerify", LLVM_VERSION_STRING,
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                        ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "mverify") {
                        FPM.addPass(MVerify());
                        return true;
                    }
                    // stuff to add here
                    return false;
                });
        }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
    return getMVerifyPluginInfo();
}
