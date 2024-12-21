MLIR_OPT=$llvm_build/bin/mlir-opt

file_name=$1

mkdir -p temp/${file_name}

${MLIR_OPT} ./${file_name}.mlir \
    --convert-vector-to-gpu="use-nvgpu=false" \
    --canonicalize \
    > ./temp/${file_name}/lower0.mlir

../build/ventus-opt ./temp/${file_name}/lower0.mlir \
    --convert-gpu-to-llvm-ventus \
    --allow-unregistered-dialect \
    > ./temp/${file_name}/lower1.mlir

sed -i 's/gpu.func/func.func/g' ./temp/${file_name}/lower1.mlir
sed -i 's/gpu.return/func.return/g' ./temp/${file_name}/lower1.mlir
sed -i 's/) kernel {/) {/g' ./temp/${file_name}/lower1.mlir
sed -i '/gpu.module/d;/^}/d' ./temp/${file_name}/lower1.mlir
sed -i 's/gpu\.container_module//g' ./temp/${file_name}/lower1.mlir

${MLIR_OPT} ./temp/${file_name}/lower1.mlir \
    --convert-vector-to-llvm \
    --convert-func-to-llvm="use-bare-ptr-memref-call-conv=true" \
    --convert-arith-to-llvm \
    --finalize-memref-to-llvm="index-bitwidth=0" \
    --cse \
    --canonicalize \
    > ./temp/${file_name}/llvm.mlir
