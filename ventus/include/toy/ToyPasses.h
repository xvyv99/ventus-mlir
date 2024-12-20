#pragma once

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

void populateGpuToLLVMSPVConversionPatterns(const LLVMTypeConverter &converter,
                                            RewritePatternSet &patterns);

/// Populates memory space attribute conversion rules for lowering
/// gpu.address_space to integer values.
void populateGpuMemorySpaceAttributeConversions_less(TypeConverter &typeConverter);

} // namespace mlir

namespace toy {

#define GEN_PASS_DECL
#include "toy/ToyPasses.h.inc"

// std::unique_ptr<mlir::Pass> createConvertGPUToVentusPass(ConvertGPUToLLVMVentusOptions options={});

#define GEN_PASS_REGISTRATION
#include "toy/ToyPasses.h.inc"

}