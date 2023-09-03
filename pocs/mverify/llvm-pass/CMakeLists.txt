# done with help from 
# https://llvm.org/devmtg/2015-10/slides/GueltonGuinet-BuildingTestingDebuggingASimpleOutOfTreePass.pdf
# in response to some warning, adjustments pulled from 
# https://github.com/quarkslab/llvm-dev-meeting-tutorial-2015/
# and more help from https://github.com/banach-space/llvm-tutor
cmake_minimum_required(VERSION 3.0)
project(mverify)

set(LLVM_ROOT "" CACHE PATH "Root of LLVM install.")

# A bit of a sanity check
if(NOT EXISTS ${LLVM_ROOT}/include/llvm)
    message(FATAL_ERROR
        "LLVM_ROOT (${LLVM_ROOT}) is invalid")
endif()

# load llvm config
list(APPEND CMAKE_PREFIX_PATH
    "${LLVM_ROOT}/share/llvm/cmake")
find_package(LLVM REQUIRED CONFIG)


# propagate LLVM setup to out project
add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})

# get ready!
add_subdirectory(mverify)
