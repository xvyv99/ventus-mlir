module attributes {gpu.container_module} {
  gpu.module @gpu_module {
    gpu.func @add_kernel(%arg0: memref<32xf32>, %arg1: memref<32xf32>, %arg2: memref<32xf32>) 
      kernel {
      %idx = gpu.global_id x
      
      %val1 = memref.load %arg0[%idx] : memref<32xf32>
      %val2 = memref.load %arg1[%idx] : memref<32xf32>
      %sum = arith.addf %val1, %val2 : f32
      
      memref.store %sum, %arg2[%idx] : memref<32xf32>

      gpu.return
    }
  }
}