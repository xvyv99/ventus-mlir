add_mlir_conversion_library(MLIRGPUToGPURuntimeTransforms_ventus
  AttrToSPIRVConverter.cpp
  GPUToLLVMConversion.cpp
  GPUOpsLowering.cpp

  DEPENDS
  MLIRToyTransformsIncGen
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
