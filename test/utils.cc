#include <cmath>
#include <iostream>
#include <ctime>

float* vec_generate_random(size_t length) {
    float* random_vec = new float[length];
    for(size_t i=0; i<length; i++)
        random_vec[i] = rand()%100;
    return random_vec;
}

float vec_diff_sum(float* vec_1, float* vec_2, size_t length) {
    float diff_sum = 0;
    for(size_t i=0; i<length; i++)
        diff_sum += std::fabs(vec_1[i]-vec_2[i]);
    return diff_sum;
}

void vec_print(float* vec, size_t length) {
    for(size_t i=0; i<length; i++)
        std::cout<<vec[i]<<' ';
    std::cout<<std::endl;
}