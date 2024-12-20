module {
  llvm.func local_unnamed_addr @vectorAdd(%arg0: !llvm.ptr<1> {llvm.align = 4 : i64, llvm.nocapture, llvm.noundef, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.align = 4 : i64, llvm.nocapture, llvm.noundef, llvm.readonly}, %arg2: !llvm.ptr<1> {llvm.align = 4 : i64, llvm.nocapture, llvm.noundef, llvm.writeonly}, %arg3: i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.call @_Z13get_global_idj(%0) : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %arg3 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr<1> -> f32
    %6 = llvm.getelementptr inbounds %arg1[%2] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr<1> -> f32
    %8 = llvm.fadd %5, %7 : f32
    %9 = llvm.fadd %8, %1 : f32
    %10 = llvm.getelementptr inbounds %arg2[%2] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, f32
    llvm.store %9, %10 {alignment = 4 : i64} : f32, !llvm.ptr<1>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }
  llvm.func @_Z13get_global_idj(i32 {llvm.noundef}) -> i32
}
