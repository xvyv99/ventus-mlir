ADD_EXECUTABLE( test_vecadd
    ${CMAKE_CURRENT_SOURCE_DIR}/test.cc
)
TARGET_LINK_LIBRARIES( test_vecadd PRIVATE GTest::gtest_main )

GTEST_DISCOVER_TESTS(test_vecadd)
