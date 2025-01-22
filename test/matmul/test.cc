#include "ventus.h"
#include "utils.h"

#include <cstddef>
#include <cstring>
#include <iostream>
#include <gtest/gtest.h>

using namespace std;

void matmul_cpu(
        float* mat_1, float* mat_2, float* mat_res, 
        size_t M, size_t N, size_t K
    ) {
    for(size_t i=0;i<M;i++) {
        for(size_t j=0;j<N;j++) {
            for(size_t k=0;k<K;k++)
                mat_res[i*N+j] += mat_1[i*K+k]*mat_2[k*K+j];
        }
    }
}

void matmul_gpu(float* vec_1, float* vec_2, size_t size) {
    uint64_t vaddr_1,vaddr_2;

    vt_device_h p=nullptr;
    vt_dev_open(&p);

    vt_buf_alloc(p,size*sizeof(float),&vaddr_1,0,0,0);//allocate arg1 buffer
    vt_buf_alloc(p,size*sizeof(float),&vaddr_2,0,0,0);//allocate arg2 buffer

    vt_copy_to_dev(p,vaddr_1,vec_1,size*sizeof(float),0,0);
    vt_copy_to_dev(p,vaddr_2,vec_2,size*sizeof(float),0,0);

    uint32_t data_3[2]={(uint32_t)vaddr_1,(uint32_t)vaddr_2};//buffer base

    char elf_name[] = "vecadd.riscv";
    launch_kernel(p, data_3, 2, elf_name);
    cout << "finish running" << endl;

    vt_copy_from_dev(p,vaddr_1,vec_1,size*sizeof(float),0,0);
    vt_copy_from_dev(p,vaddr_2,vec_2,size*sizeof(float),0,0);

    vt_buf_free(p,0,nullptr,0,0);
}

TEST(vecadd, 0) {
    srand(time(0));

    const size_t M = 2;
    const size_t N = 2;
    const size_t K = 2;

    const float tol = 1E-4;

    float* mat_a = vec_generate_random(M*K);
    float* mat_b = vec_generate_random(K*N);

    float* mat_res_cpu = new float[M*N]; 
    float* mat_res_gpu = new float[M*N];

    mat_print(mat_a, M, K);
    mat_print(mat_b, K, N);

    matmul_cpu(mat_a, mat_b, mat_res_cpu, M, N, K);
    // vecadd_gpu(vec_a_gpu, vec_b, vec_size);

    mat_print(mat_res_cpu, M, N);
    vec_print(mat_res_cpu, M*N);

    // std::cout<<"Difference sum between two vector: "<<vec_diff_sum(vec_a_cpu, vec_a_gpu, vec_size)<<std::endl;

    // EXPECT_TRUE(vec_diff_sum(vec_a_cpu, vec_a_gpu, vec_size)<=tol);

    delete[] mat_a;
    delete[] mat_b;
    delete[] mat_res_cpu;
    delete[] mat_res_gpu;
}
