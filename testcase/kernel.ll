; ModuleID = 'kernel.cl'
source_filename = "kernel.cl"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128-A5-G1"
target triple = "riscv32"

; Function Attrs: convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) vscale_range(1,2048)
define void @vectorAdd(ptr addrspace(1) nocapture noundef readonly align 4 %0, ptr addrspace(1) nocapture noundef readonly align 4 %1, ptr addrspace(1) nocapture noundef writeonly align 4 %2, i32 noundef %3) local_unnamed_addr {
  %5 = call i32 @_Z13get_global_idj(i32 noundef 0) 
  %6 = icmp ult i32 %5, %3
  br i1 %6, label %7, label %15

7:                                                ; preds = %4
  %8 = getelementptr inbounds float, ptr addrspace(1) %0, i32 %5
  %9 = load float, ptr addrspace(1) %8, align 4
  %10 = getelementptr inbounds float, ptr addrspace(1) %1, i32 %5
  %11 = load float, ptr addrspace(1) %10, align 4
  %12 = fadd float %9, %11
  %13 = fadd float %12, 1.000000e+00
  %14 = getelementptr inbounds float, ptr addrspace(1) %2, i32 %5
  store float %13, ptr addrspace(1) %14, align 4
  br label %15

15:                                               ; preds = %7, %4
  ret void
}

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @_Z13get_global_idj(i32 noundef)
