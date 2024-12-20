#ifndef VENTUS_PASSES_H
#define VENTUS_PASSES_H

#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Transforms/DialectConversion.h"

#include <memory>

namespace mlir {
class DialectRegistry;
class LLVMTypeConverter;
class RewritePatternSet;
class Pass;
class TypeConverter;

void populateGpuToLLVMSPVConversionPatterns(
    LLVMTypeConverter &converter,
    RewritePatternSet &patterns
);

} // namespace mlir

namespace ventus {

#define GEN_PASS_DECL
#include "GPUToLLVMVentus/GPUToLLVMVentusPass.h.inc"

#define GEN_PASS_REGISTRATION
#include "GPUToLLVMVentus/GPUToLLVMVentusPass.h.inc"

}

#endif // VENTUS_PASSES_H