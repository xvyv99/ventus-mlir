#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/IR/DialectRegistry.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/GPU/IR/GPUDialect.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Transforms/Passes.h"
#include "toy/ToyPasses.h"
using namespace mlir;
using namespace llvm;

int main(int argc, char ** argv) {
  DialectRegistry registry;
  registry.insert< 
    scf::SCFDialect, 
    gpu::GPUDialect, 
    func::FuncDialect,
    memref::MemRefDialect,
    LLVM::LLVMDialect
  >();
  registerCSEPass();
  registerCanonicalizerPass();
  toy::registerPasses();
  return asMainReturnCode(MlirOptMain(argc, argv, "toy-opt", registry));
}
