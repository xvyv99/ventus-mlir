cmake_policy(SET CMP0135 NEW)

include_directories(include)

INCLUDE(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)

# For Windows: Prevent overriding the parent project's compiler/linker settings
SET(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

INCLUDE(GoogleTest)

# Define KERNEL_ADDRESS if not already defined (default: 0x800000b8)
if(NOT DEFINED KERNEL_ADDRESS)
  message(STATUS "KERNEL_ADDRESS not specified, using default address 0x800000b8")
  set(KERNEL_ADDRESS "0x800000b8")
else()
  message(STATUS "Using specified KERNEL_ADDRESS: ${KERNEL_ADDRESS}") 
endif()

add_compile_definitions(KERNEL_ADDRESS=${KERNEL_ADDRESS})

set(PROJECT spike_driver)
set(SPIKE_SRC_DIR /home/xvyv99/My_Data/Project/gpgpu/ventus-gpgpu-isa-simulator)
set(SPIKE_TARGET_DIR /home/xvyv99/My_Data/Project/gpgpu/llvm-project/install)
set(VENTUS_INSTALL_PREFIX /home/xvyv99/My_Data/Project/gpgpu/llvm-project/install)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS -lstdc++)

include_directories(${SPIKE_SRC_DIR})
include_directories(${SPIKE_SRC_DIR}/spike_main)
include_directories(${SPIKE_SRC_DIR}/riscv)
include_directories(${SPIKE_SRC_DIR}/build)
include_directories(${SPIKE_SRC_DIR}/softfloat)
include_directories(${SPIKE_SRC_DIR}/fesvr)

#set(CMAKE_POSITION_INDEPENDENT_CODE True)

file(GLOB_RECURSE SRCS ./ventus.cpp)

link_directories(${SPIKE_TARGET_DIR}/lib)

add_library(${PROJECT} SHARED ${SRCS})

target_link_libraries(${PROJECT} PUBLIC spike_main)

set_target_properties(${PROJECT} PROPERTIES OUTPUT_NAME "${PROJECT}")
set_target_properties(${PROJECT} PROPERTIES CLEAN_DIRECT_OUTPUT 1)

add_spike_test(vecadd_gpu) # 非常奇怪的一点是若这个文件夹名为 vecadd_gpu2llvm 时, 测试就无法通过, 而名称为 vecadd 和 vecadd_gpu 时则正常
add_spike_test(matmul)