#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/IR/DialectRegistry.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/GPU/IR/GPUDialect.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Transforms/Passes.h"

#include "GPUToLLVMVentus/GPUToLLVMVentusPass.h"

int main(int argc, char ** argv) {
  mlir::DialectRegistry registry;
  registry.insert< 
    mlir::scf::SCFDialect, 
    mlir::gpu::GPUDialect, 
    mlir::func::FuncDialect,
    mlir::memref::MemRefDialect,
    mlir::LLVM::LLVMDialect
  >();
  mlir::registerCSEPass();
  mlir::registerCanonicalizerPass();
  ventus::registerPasses();
  return mlir::asMainReturnCode(MlirOptMain(argc, argv, "ventus-opt", registry));
}
