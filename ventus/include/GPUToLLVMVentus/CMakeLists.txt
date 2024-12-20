set(LLVM_TARGET_DEFINITIONS GPUToLLVMVentusPass.td)
mlir_tablegen(GPUToLLVMVentusPass.h.inc -gen-pass-decls)
add_public_tablegen_target(MLIRVentusIncGen)

add_custom_target(header DEPENDS MLIRToyIncGen MLIRVentusIncGen)