# setup test dependencies
# googletest has some code they explain on how to set it up; put that here

add_executable(MyUnitTests
    # ...
)

target_link_libraries(MyUnitTests gtest_main)

# CMake will not generate the tests unless enable_testing() has been called
add_test(MyUnitTestName MyUnitTests)
