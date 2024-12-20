add_mlir_library( GPUToLLVMVentus
  GPUToLLVMVentus.cpp
  DEPENDS
    MLIRVentusIncGen
  LINK_LIBS 
    MLIRGPUDialect
    MLIRLLVMDialect
    MLIRFuncDialect
    MLIRSPIRVDialect
    MLIRLLVMCommonConversion
    MLIRGPUToGPURuntimeTransforms_Ventus
)