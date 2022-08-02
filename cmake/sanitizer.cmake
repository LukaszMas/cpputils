# Ported from Clickhouse: https://github.com/ClickHouse/ClickHouse/blob/master/cmake/sanitize.cmake

set(SAN_FLAGS "${SAN_FLAGS} -g -fno-omit-frame-pointer -DSANITIZER")
# Optimization level: O1 is normally set by clang vs -Og by gcc
if (COMPILER_GCC)
    message(STATUS "Setting sanitizer flags for GCC compiler:")
    set (SAN_FLAGS "${SAN_FLAGS} -Og")
else ()
  message(STATUS "Setting sanitizer flags for Clang compiler:")
    set (SAN_FLAGS "${SAN_FLAGS} -O1")
endif ()

if (NOT "${SANITIZER}" STREQUAL "")
    if (SANITIZER STREQUAL "address")
        set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SAN_FLAGS} -fsanitize=address -fsanitize-address-use-after-scope")
        set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SAN_FLAGS} -fsanitize=address -fsanitize-address-use-after-scope")
        set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address -fsanitize-address-use-after-scope")
        if (COMPILER_GCC)
            set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -static-libasan")
            set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libasan")
            set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libasan")
        endif ()

    elseif (SANITIZER STREQUAL "memory")
        if (COMPILER_GCC)
          message (FATAL_ERROR "Memory sanitizer with GNU compiler is not currently supported.")
        endif()
        set (MSAN_FLAGS "-fsanitize=memory -fsanitize-memory-track-origins -fno-optimize-sibling-calls")

        set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SAN_FLAGS} ${MSAN_FLAGS}")
        set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SAN_FLAGS} ${MSAN_FLAGS}")
        set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=memory")

    elseif (SANITIZER STREQUAL "undefined")
        set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SAN_FLAGS} -fsanitize=undefined -fno-sanitize-recover=all")
        set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SAN_FLAGS} -fsanitize=undefined -fno-sanitize-recover=all")
        set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=undefined")

        if (COMPILER_GCC)
            set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -static-libubsan")
            set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libubsan")
            set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libubsan")
        endif ()
    else ()
        message (FATAL_ERROR "Unknown sanitizer type: ${SANITIZER}")
    endif ()

    # Disable sanitizing on make stage e.g. for snowball compiler
    set (ENV{ASAN_OPTIONS} "detect_leaks=0")
    message (STATUS "Sanitizer CFLAGS: ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE_UC}}")
    message (STATUS "Sanitizer CXXFLAGS: ${CMAKE_CXX_FLAGS} ${CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE_UC}}")
else()
    message (STATUS "Sanitizer not enabled: ${SANITIZER}")
endif()
