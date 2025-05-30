cmake_minimum_required(VERSION 3.19)
project(expense-report-refactoring-cpp-kata CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(FetchGTest)
fetch_gtest()

include(GoogleTest)

enable_testing()

file(GLOB tests test_*.cpp)
foreach(test ${tests})
    get_filename_component(name ${test} NAME_WE)
    add_executable(${name} ${test})
    target_link_libraries(${name} PRIVATE GTest::gmock_main)

    gtest_discover_tests(${name})
endforeach()

if(UNIX)
    add_custom_target(
        copy-compile-commands ALL
        ${CMAKE_COMMAND}
        -E
        copy_if_different
        ${CMAKE_BINARY_DIR}/compile_commands.json
        ${CMAKE_CURRENT_LIST_DIR}
    )
endif()
