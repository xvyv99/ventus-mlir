VENTUS_INSTALL_PREFIX ?= /root/ventus/llvm-project/install
VENTUS_OPT ?= ../../build/ventus-opt
MLIR_OPT ?= mlir-opt-19
MLIR_TRANSLATE ?= mlir-translate-19

SOURCE_PATH ?= ./

all: matmul_llvm.mlir

matmul_llvm.mlir: ${SOURCE_PATH}/matmul.mlir
	${MLIR_OPT} $^ \
		-convert-linalg-to-loops -lower-affine -convert-scf-to-cf \
		-convert-vector-to-llvm -convert-arith-to-llvm \
		--convert-func-to-llvm="use-bare-ptr-memref-call-conv=true" \
		--finalize-memref-to-llvm \
		-reconcile-unrealized-casts \
		> $@ -o ./log.mlir

matmul_llvm.ll: matmul_llvm.mlir
	${MLIR_TRANSLATE} --mlir-to-llvmir $^ > $@
	sed -i 's/define void @add_kernel/define ventus_kernel void @add_kernel/g' $@
	
matmul_llvm.o: matmul_llvm.ll
	${VENTUS_INSTALL_PREFIX}/bin/llc -mtriple=riscv32 -mcpu=ventus-gpgpu --filetype=obj $^ -o $@

matmul.riscv: matmul_llvm.o
	${VENTUS_INSTALL_PREFIX}/bin/ld.lld -o $@ \
		-T ${VENTUS_INSTALL_PREFIX}/lib/ldscripts/ventus/elf32lriscv.ld $^ \
		${VENTUS_INSTALL_PREFIX}/lib/crt0.o ${VENTUS_INSTALL_PREFIX}/lib/riscv32clc.o \
		-L${VENTUS_INSTALL_PREFIX}/lib -lworkitem --gc-sections --init ${KERNEL_FUNC}

clean:
	rm -f matmul_llvm.mlir