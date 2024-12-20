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

void populateGpuToLLVMSPVConversionPatterns(LLVMTypeConverter &converter,
                                            RewritePatternSet &patterns);

} // namespace mlir

namespace toy {

#define GEN_PASS_DECL
#include "toy/ToyPasses.h.inc"

#define GEN_PASS_REGISTRATION
#include "toy/ToyPasses.h.inc"

}