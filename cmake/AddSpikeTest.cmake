function(add_spike_test target)

  ADD_EXECUTABLE( test_${target}
      ${CMAKE_CURRENT_SOURCE_DIR}/${target}/${target}.cc
  )
  TARGET_LINK_LIBRARIES( test_${target} PRIVATE GTest::gtest_main )

  GTEST_DISCOVER_TESTS( test_${target} )

  # Define KERNEL_ADDRESS if not already defined (default: 0x800000b8)
  if(NOT DEFINED KERNEL_ADDRESS)
    message(STATUS "KERNEL_ADDRESS not specified, using default address 0x800000b8")
    set(KERNEL_ADDRESS "0x800000b8")
  else()
    message(STATUS "Using specified KERNEL_ADDRESS: ${KERNEL_ADDRESS}") 
  endif()

  add_compile_definitions(KERNEL_ADDRESS=${KERNEL_ADDRESS})

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

  add_executable(spike_test 
      ${CMAKE_CURRENT_SOURCE_DIR}/${target}/test.cpp
      ${CMAKE_CURRENT_SOURCE_DIR}/utils.cc
  )

  add_dependencies(spike_test ${PROJECT})
  target_link_libraries(spike_test PUBLIC ${PROJECT})

  configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/${target}/${target}.riscv
    ${CMAKE_BINARY_DIR}/${target}.riscv
    COPYONLY
  )

endfunction()