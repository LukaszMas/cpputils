if(ENABLE_ANALYZER)
  if(COMPILER_CLANG)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --analyze -Xanalyzer -analyzer-output=text")
    set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} --analyze")
  elseif(COMPILER_GCC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fanalyzer")
    set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -fanalyzer")
  else()
    message(STATUS "Static analyzer flags not supported for current compiler: ${CMAKE_CXX_COMPILER_ID}")
  endif()
endif()