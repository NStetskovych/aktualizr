# set symbols used when compiling
add_definitions(-DBOOST_LOG_DYN_LINK=1)

# find all required libraries
find_package(Boost COMPONENTS system thread program_options log log_setup regex REQUIRED)
find_package(PkgConfig REQUIRED)
pkg_search_module(LIBCURL REQUIRED libcurl)
pkg_search_module(LIBOPENSSL REQUIRED libssl)

# configure libraries
set(LINK_LIBS libpthread.so
              ${Boost_SYSTEM_LIBRARY}
              ${Boost_THREAD_LIBRARY}
              ${Boost_LOG_LIBRARIES}
              ${Boost_LOG_SETUP_LIBRARIES}
              ${Boost_PROGRAM_OPTIONS_LIBRARY}
              ${Boost_REGEX_LIBRARY}
              ${LIBCURL_LIBRARIES})


# set source files excluded main for using the list for the test target
set(SOURCES src/logger.cc
            src/httpclient.cc
            src/sotahttpclient.cc
            src/interpreter.cc
            src/config.cc
            src/main.cc)

set(HEADERS src/logger.h
            src/config.h
            src/interpreter.h
            src/httpclient.h
            src/sotahttpclient.h)


# set output folder
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY target/)

# set the name of the executable
add_executable(sota_client ${SOURCES})

# define libraries for the target
target_link_libraries(sota_client ${LINK_LIBS})

