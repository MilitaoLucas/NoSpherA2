cmake_minimum_required(VERSION 3.14)
project(OpenBLAS)
include("${CPM_PATH}")
set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
set(BLA_STATIC ON)
set(BLA_PREFER_STATIC ON)
if(WIN32)
    set(CMAKE_FIND_LIBRARY_SUFFIXES .lib)
    set(LIBOMP_ENABLE_SHARED ON)
endif()
include(ExternalProject)
if (BUILD_OPENBLAS)
    if (NOT "${CMAKE_Fortran_COMPILER}")
        set(CMAKE_Fortran_COMPILER "gfortran")
        if (WINDOWS_CROSS_COMPILE)
            set(CMAKE_Fortran_COMPILER "gfortran")
        endif()
    endif()
    if(NOT (WIN32 OR WINDOWS_CROSS_COMPILE))
        CPMAddPackage(
            NAME openblas
            GITHUB_REPOSITORY "OpenMathLib/OpenBLAS"
            VERSION "0.3.29"
            GIT_TAG "v0.3.29"
            DOWNLOAD_ONLY YES
        )
        set(BLAS_LAPACK_SOURCE_DIR "${_CPM_DEPENDENCY_openblas_SOURCE_DIR}")
        message(WARNING "BLAS_SOURC_DIR ${BLAS_LAPACK_SOURCE_DIR}")
        if(openblas_ADDED)
            ExternalProject_Add(
              ../../3rdparty/OpenBLAS
              SOURCE_DIR ${openblas_SOURCE_DIR}
              DEPENDS openmp
              BUILD_IN_SOURCE ON
              BUILD_COMMAND make FC=${CMAKE_Fortran_COMPILER} USE_OPENMP=1 -j
              INSTALL_COMMAND make install PREFIX=${CMAKE_BINARY_DIR}/3rdparty/openblas

              BUILD_BYPRODUCTS ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a
              LOG_BUILD ON
            )
            # Create imported target
            add_library(openblas STATIC IMPORTED GLOBAL)
            add_dependencies(openblas OpenBLAS)
            set_target_properties(openblas PROPERTIES
                IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a
            )
            file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/3rdparty/openblas/include)
            set(OPENBLAS_INCLUDE_DIR ${CMAKE_BINARY_DIR}/3rdparty/openblas/include PARENT_SCOPE)
            message(WARNING ${OPENBLAS_INCLUDE_DIR})
            target_include_directories(openblas INTERFACE ${CMAKE_BINARY_DIR}/3rdparty/openblas/include)

            set(DESTINATION_INCLUDE_DIR "${CMAKE_BINARY_DIR}/3rdparty/openblas/include")
            set(openblas_SOURCE_DIR ${CMAKE_BINARY_DIR}/_deps/openblas-src)

            message(WARNING "SOURCE DIR: ${openblas_SOURCE_DIR}")
            file(MAKE_DIRECTORY "${DESTINATION_INCLUDE_DIR}")
        endif ()
    else()
        set(BLAS_LAPACK_HEADERS
          cblas.h
          f77blas.h
          lapack.h
          lapacke.h
          lapacke_config.h
          lapacke_mangling.h
          lapacke_utils.h
          openblas_config.h
        )
        set(DESTINATION_INCLUDE_DIR "${CMAKE_BINARY_DIR}/3rdparty/openblas/include")
        set(openblas_SOURCE_DIR ${CMAKE_BINARY_DIR}/_deps/openblas-src)
        CPMAddPackage(
            NAME ../../3rdparty/OpenBLAS
            GITHUB_REPOSITORY "OpenMathLib/OpenBLAS"
            VERSION "0.3.29"
            GIT_TAG "v0.3.29"
            SOURCE_DIR ${openblas_SOURCE_DIR}
            OPTIONS
                "G Visual Studio 17 2022"
                "CMAKE_BUILD_TYPE Release"
                "NOFORTRAN OFF"
            HEADER_DIRS include
        )
        message(WARNING "SOURCE DIR: ${openblas_SOURCE_DIR}")
        message(WARNING "DESTINATION DIR: ${DESTINATION_INCLUDE_DIR}")
        set(OPENBLAS_INCLUDE_DIR ${DESTINATION_INCLUDE_DIR} PARENT_SCOPE)
        add_library(openblas STATIC IMPORTED GLOBAL)
        add_dependencies(openblas OpenBLAS)
    endif()
endif()
