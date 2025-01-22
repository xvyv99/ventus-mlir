function(add_spike_test target)
  add_executable( test_${target} 
      ${CMAKE_CURRENT_SOURCE_DIR}/${target}/test.cc
      ${CMAKE_CURRENT_SOURCE_DIR}/utils.cc
  )

  add_dependencies( test_${target} ${PROJECT} )
  target_link_libraries( test_${target}  
    PUBLIC ${PROJECT}
    PRIVATE GTest::gtest_main 
  )

  GTEST_DISCOVER_TESTS( test_${target} )

  add_custom_target(
    ${target}.riscv
    COMMAND make -f ${CMAKE_CURRENT_SOURCE_DIR}/${target}/Makefile 
      VENTUS_INSTALL_PREFIX=${VENTUS_INSTALL_PREFIX}
      VENTUS_OPT=${CMAKE_BINARY_DIR}/ventus-opt
      SOURCE_PATH=${CMAKE_CURRENT_SOURCE_DIR}/${target}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    DEPENDS ventus-opt
  )

  add_dependencies(test_${target} ${target}.riscv)
  
endfunction()