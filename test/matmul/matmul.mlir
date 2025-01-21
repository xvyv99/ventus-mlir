#map0 = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0) -> (d0, 0)>
#map5 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {gpu.container_module} {
  gpu.module @kernels {
    gpu.func @matmul(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf32>) kernel {
      %c0 = arith.constant 0 : index
      %cst = arith.constant 0.000000e+00 : f16
      %cst_f32 = arith.constant 0.000000e+00 : f32
      %A = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<16x16xf16>, vector<16x16xf16>
      %B = vector.transfer_read %arg1[%c0, %c0], %cst {permutation_map = #map0, in_bounds = [true, true]} : memref<16x16xf16>, vector<16x16xf16>
      %C = vector.transfer_read %arg2[%c0, %c0], %cst_f32 {in_bounds = [true, true]} : memref<16x16xf32>, vector<16x16xf32>
      %D = vector.contract {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %A, %B, %C : vector<16x16xf16>, vector<16x16xf16> into vector<16x16xf32>
      vector.transfer_write %D, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<16x16xf32>
      gpu.return
    }
  }
}