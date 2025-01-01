cmake_policy(SET CMP0135 NEW)

set(PROJECT spike_driver)
set(SPIKE_SRC_DIR /home/xvyv99/My_Data/Project/gpgpu/ventus-gpgpu-isa-simulator)
set(SPIKE_TARGET_DIR /home/xvyv99/My_Data/Project/gpgpu/llvm-project/install)

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

# add_subdirectory(vecadd)

add_spike_test(vecadd)