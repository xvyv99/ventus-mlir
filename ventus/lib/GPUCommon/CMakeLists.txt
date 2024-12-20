add_mlir_conversion_library(MLIRGPUToGPURuntimeTransforms_Ventus
  GPUToLLVMConversion.cpp
  GPUOpsLowering.cpp

  DEPENDS
  MLIRVentusIncGen
  intrinsics_gen

  LINK_COMPONENTS
  Core
  MC

  LINK_LIBS PUBLIC
  MLIRArithToLLVM
  MLIRAsyncToLLVM
  MLIRControlFlowToLLVM
  MLIRConvertToLLVMPass
  MLIRFuncToLLVM
  MLIRGPUTransforms
  MLIRIR
  MLIRLLVMCommonConversion
  MLIRLLVMDialect
  MLIRFuncDialect
  MLIRMemRefToLLVM
  MLIRPass
  MLIRSupport
  MLIRVectorToLLVM
)

