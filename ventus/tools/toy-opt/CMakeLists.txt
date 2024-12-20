add_mlir_tool(toy-opt toy-opt.cpp)
target_link_libraries(toy-opt
  PRIVATE
  MLIRIR MLIRParser MLIRSupport
  MLIROptLib        # 对应 #include "mlir/Tools/mlir-opt/MlirOptMain.h"
  MLIRFuncDialect   # 对应 #include "mlir/Dialect/Func/IR/FuncOps.h"
  MLIRGPUDialect
  MLIRSCFDialect
  MLIRMemRefDialect
  MLIRLLVMDialect
  
  MLIRTransforms    # 对应 #include "mlir/Transforms/Passes.h"
  ToyTransforms
)