VENTUS_INSTALL_PREFIX ?= /root/ventus/llvm-project/install
VENTUS_OPT ?= ../../build/ventus-opt
MLIR_OPT ?= mlir-opt-19
MLIR_TRANSLATE ?= mlir-translate-19

SOURCE_PATH ?= ./

KERNEL_FUNC = add_kernel

all: vecadd.riscv

vecadd_lower.mlir: ${SOURCE_PATH}/vecadd.mlir
	${VENTUS_OPT} --convert-gpu-to-llvm-ventus $^ > $@
	
	sed -i 's/gpu.func/func.func/g' $@
	sed -i 's/gpu.return/func.return/g' $@
	sed -i 's/) kernel {/) {/g' $@
	sed -i '2d;13d' $@

vecadd_llvm.mlir: vecadd_lower.mlir
	${MLIR_OPT} $^ \
    --convert-vector-to-llvm \
    --convert-func-to-llvm="use-bare-ptr-memref-call-conv=true" \
    --convert-arith-to-llvm \
    --finalize-memref-to-llvm="index-bitwidth=0" \
    --cse \
    --canonicalize \
    > $@

vecadd_llvm.ll: vecadd_llvm.mlir
	${MLIR_TRANSLATE} --mlir-to-llvmir $^ > $@
	sed -i 's/define void @add_kernel/define ventus_kernel void @add_kernel/g' $@
	
vecadd_llvm.o: vecadd_llvm.ll
	${VENTUS_INSTALL_PREFIX}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj $^ -o $@

vecadd.riscv: vecadd_llvm.o
	${VENTUS_INSTALL_PREFIX}/bin/ld.lld -o $@ \
		-T ${VENTUS_INSTALL_PREFIX}/lib/ldscripts/ventus/elf32lriscv.ld $^ \
		${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o \
		-L${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init ${KERNEL_FUNC}

clean:
	rm -f vecadd_lower.mlir
	rm -f vecadd_llvm.*
	rm vecadd.riscv