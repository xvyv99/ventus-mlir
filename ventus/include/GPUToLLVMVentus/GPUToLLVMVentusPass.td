#ifndef VENTUS_PASSES_TD
#define VENTUS_PASSES_TD

include "mlir/Pass/PassBase.td"
include "mlir/Dialect/Func/IR/FuncOps.td"

def ConvertGPUToLLVMVentus : Pass<"convert-gpu-to-llvm-ventus", "mlir::gpu::GPUModuleOp"> {
  let summary = "Convert GPU dialect To Ventus LLVM IR.";
  let dependentDialects = ["mlir::LLVM::LLVMDialect", "mlir::func::FuncDialect"];
  let options = [
    Option<"indexBitwidth", "index-bitwidth", "unsigned",
           /*default=kDeriveIndexBitwidthFromDataLayout*/"0",
           "Bitwidth of the index type, 0 to use size of machine word">,
  ];
}

#endif
