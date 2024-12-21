add_mlir_tool(ventus-opt ventus-opt.cpp)
target_link_libraries(ventus-opt
  PRIVATE
  MLIRIR MLIRParser MLIRSupport
  MLIROptLib        # 对应 #include "mlir/Tools/mlir-opt/MlirOptMain.h"
  MLIRFuncDialect   # 对应 #include "mlir/Dialect/Func/IR/FuncOps.h"
  MLIRGPUDialect
  MLIRSCFDialect
  MLIRMemRefDialect
  MLIRLLVMDialect
  MLIRVectorDialect
  
  MLIRTransforms    # 对应 #include "mlir/Transforms/Passes.h"
  GPUToLLVMVentus
)