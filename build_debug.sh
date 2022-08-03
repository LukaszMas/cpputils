#!/bin/bash

# Set the script to exit when on failing command
set -e

# Parse passed sanitizer argument
SANITIZER=""
if [ ! -z "$1" ]
  then
    SANITIZER=$1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BUILD_DIR=${SCRIPT_DIR}/debug_build

mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}

cmake -g ninja -DCMAKE_BUILD_TYPE=Debug\
    -DCMAKE_CXX_COMPILER=clang++\
    -DCMAKE_C_COMPILER=clang\
    -DWITH_SANITIZER=${SANITIZER}\
    -S ${SCRIPT_DIR} -B . && make -j$(nproc --ignore=2)

echo -e "\n** [ Debug build completed at: ${BUILD_DIR} ] **\n"
