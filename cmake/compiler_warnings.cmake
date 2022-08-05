# Custom warning messages for different compilers GCC or Clang
if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  set(COMPILER_GCC 1)
  target_compile_options("${TARGET_NAME}" PRIVATE
                        -Wall
                        -Warray-bounds
                        -Wcast-qual
                        -Wclobbered
                        -Wdouble-promotion
                        -Wduplicated-branches
                        -Wduplicated-cond
                        -Werror=return-type
                        -Wextra
                        -Wformat=2
                        -Wlogical-op
                        -Wmaybe-uninitialized
                        -Wmissing-field-initializers
                        -Wno-free-nonheap-object
                        -Wnull-dereference
                        -Wpointer-arith
                        -Wstrict-aliasing
                        -Wstrict-overflow
                        -Wunreachable-code
                        -Wunused-but-set-variable
                        -Wwrite-strings
                      )
  message("GNU compiler warning messages added")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  set(COMPILER_CLANG 1)
  target_compile_options("${TARGET_NAME}" PRIVATE
                        -Wall
                        -Wambiguous-member-template
                        -Warray-bounds
                        -Wbind-to-temporary-copy
                        -Wcast-qual
                        -Wdouble-promotion
                        -Werror=return-type
                        -Wextra
                        -Wextra-tokens
                        -Wfloat-equal
                        -Wformat
                        -Wformat-extra-args
                        -Wformat-invalid-specifier
                        -Wformat=2
                        -Wignored-qualifiers
                        -Wmissing-field-initializers
                        -Wnon-pod-varargs
                        -Wnonnull
                        -Woverloaded-virtual
                        -Wpointer-arith
                        -Wself-assign
                        -Wsign-compare
                        -Wtype-limits
                        -Wuninitialized
                        -Wunreachable-code
                        -Wunused-private-field
                        -Wwrite-strings
                      )
  message("Clang compiler warning messages added")
else()
  message("No warning messages added")
endif()
