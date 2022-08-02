# CMake file for cpputils library
cmake_minimum_required(VERSION 3.11)

# Project name
project(Cpputils LANGUAGES CXX C)

# Add module path
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Set Compiler Sanitizers
set(SANTIIZER_OPTIONS address memory undefined "Sanitizer options")
set(SANITIZER ${WITH_SANITIZER} CACHE STRING "Select sanitizer" FORCE)
set_property(CACHE SANITIZER PROPERTY STRINGS ${SANTIIZER_OPTIONS})

# Set additional CMake flags
set(CMAKE_VERBOSE_MAKEFILE on)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export symbols so that the backtraces are useful
set(CMAKE_ENABLE_EXPORTS ON)

# Enable debug information for C++ standard libraries
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_GLIBCXX_DEBUG")

# Generate compile_commands.json for text editors like vim or IDE tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Set Target Name
set(TARGET_NAME "cpputils")

set(SOURCES
    src/errno.cpp
)

add_library(${TARGET_NAME} STATIC
    ${SOURCES}
)

target_link_libraries(${TARGET_NAME}
    PUBLIC
)

target_include_directories(${TARGET_NAME}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/
)

# Include compiler warnings
include(cmake/compiler_warnings.cmake)
# Include sanitizer
if (NOT SANITIZER STREQUAL "")
  include(cmake/sanitizer.cmake)
endif ()
