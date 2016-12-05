##
# cmake Makefile for the sota_client_cpp
# 
# Copyright (c) 2016 Advanced Telematic Systems GmbH
# 
# Author: Moritz Klinger - mklinger@embeddeers.com 
#

# define the minimum cmake version that is required
cmake_minimum_required (VERSION 2.6)

# define a project name
PROJECT(sota_client_cpp)

# set build type to Debug or Release here
set(CMAKE_BUILD_TYPE Release)

# set symbols used when compiling
add_definitions(-DBOOST_LOG_DYN_LINK=1)

# configure libraries
set(LINK_LIBS libpthread.so
              libboost_system.so
              libboost_thread.so
              libboost_log_setup.so 
              libboost_log.so
              libboost_program_options.so)

# set local include directory(ies)
set(INC_DIR inc/)

# set variable for the source directory
set(SRC_DIR src/)

# tell cmake to include directory(ies)
include_directories(${INC_DIR})

# set source files
set(SOURCES ${SRC_DIR}main.cpp
            ${SRC_DIR}logger.cpp
            ${INC_DIR}logger.hpp)

# set output folder
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY target/)

# set the name of the executable
add_executable(sota_client ${SOURCES})

# define libraries for the target
target_link_libraries(sota_client ${LINK_LIBS})

###############################################################################

# enable cmakes test functionality
enable_testing()

# The test feature of cmake checks the return value when the program
# exits. If the return value is zero, the testcase passes.

# test running the executable with command line option --help
add_test(NAME feat1_test--help
         COMMAND sota_client --help)     
# test running the executable with command line option -h          
add_test(NAME feat1_test-h
         COMMAND sota_client -h)
# test running the executable with command line option --something
add_test(NAME feat1_test--something
         COMMAND sota_client --something)
# test running the executable with command line option -sth
add_test(NAME feat1_test-sth
         COMMAND sota_client -sth)
# test running the executable without command line options
add_test(NAME feat1_test-no_opt
         COMMAND sota_client)
         
# testcases with non-supported command line options will return 1
# in this case we want the testcase to pass         
set_tests_properties(feat1_test--something feat1_test-sth PROPERTIES WILL_FAIL TRUE)
         