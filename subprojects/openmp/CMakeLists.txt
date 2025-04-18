cmake_minimum_required(VERSION 3.14)
project(OpenMP)
include("${CPM_PATH}")
set(LIBOMP_ENABLE_SHARED OFF)
set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
set(BLA_STATIC ON)
set(BLA_PREFER_STATIC ON)
if(WIN32)
    set(CMAKE_FIND_LIBRARY_SUFFIXES .lib)
    set(LIBOMP_ENABLE_SHARED ON)
endif()
include(ExternalProject)
message(${CMAKE_CURRENT_BINARY_DIR}/openmp)
message(STATUS "BUILD ${BUILD_OPENMP}")
if (NOT BUILD_OPENMP)
    find_package(OpenMP QUIET)
    if (OpenMP_FOUND)
        message(STATUS "Using system OpenMP: ${OpenMP_gomp_LIBRARY}")
        message(STATUS "OpenMP flags: ${OpenMP_CXX_FLAGS}")
        message(STATUS "OpenMP CXX LIBRARY: ${OpenMP_CXX_LIBRARIES}")
        add_library(openmp INTERFACE IMPORTED GLOBAL)
        add_dependencies(openmp OpenMP)
        target_compile_options(openmp INTERFACE ${OpenMP_CXX_FLAGS})
        target_link_libraries(openmp INTERFACE ${OpenMP_omp_LIBRARY})
        set(OPENMP_LIBRARY ${OpenMP_gomp_LIBRARY} )
    else()
        set(BUILD_OPENMP ON)
    endif()
endif ()
message(STATUS "BUILD OPENMP: ${BUILD_OPENMP}")
if (BUILD_OPENMP AND (NOT WIN32))
    ExternalProject_Add(llvm_openmp
        SOURCE_DIR ../../3rdparty/llvm-min/openmp
        PREFIX ${CMAKE_CURRENT_BINARY_DIR}/openmp
        CMAKE_ARGS
            -GNinja
            -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            -DCMAKE_BUILD_TYPE=Release
            -DLIBOMP_ENABLE_SHARED=OFF
            -DLIBOMP_FORTRAN_MODULES=ON
            -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/openmp

        BUILD_BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/openmp/src/llvm_openmp-build/runtime/src/libomp.a
    )
    file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/openmp/include)
    add_library(openmp INTERFACE IMPORTED GLOBAL)
    add_dependencies(openmp llvm_openmp)
    target_link_libraries(openmp INTERFACE openmp)
    target_include_directories(
        openmp INTERFACE
          ${CMAKE_CURRENT_BINARY_DIR}/openmp/include
    )
    set(OPENMP_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/openmp/src/llvm_openmp-build/runtime/src/libomp.a )
    if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        set(OpenMP_CXX_FLAGS "-fopenmp=libomp" )
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(OpenMP_CXX_FLAGS "-fopenmp" )
    endif ()

endif()

if (WIN32 OR WINDOWS_CROSS_COMPILE)
    set(OpenMP_CXX_FLAGS "" )
endif ()
