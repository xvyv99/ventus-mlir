mkdir -p temp

../build/ventus-opt --convert-gpu-to-llvm-ventus ./vecadd_gpu.mlir > ./temp/vecadd_i.mlir

sed -i 's/gpu.func/func.func/g' ./temp/vecadd_i.mlir
sed -i 's/gpu.return/func.return/g' ./temp/vecadd_i.mlir
sed -i 's/) kernel {/) {/g' ./temp/vecadd_i.mlir

mlir-opt-19 ./temp/vecadd_i.mlir \
    --finalize-memref-to-llvm \
    --convert-arith-to-llvm \
    --cse \
    --canonicalize \
    --buffer-deallocation \
    --buffer-hoisting \
    > ./temp/vecadd_i1.mlir

mlir-opt-19 ./temp/vecadd_i1.mlir \
    --convert-func-to-llvm \
    --cse \
    --canonicalize \
    --buffer-deallocation \
    --buffer-hoisting \
    > ./temp/vecadd_llvm.mlir