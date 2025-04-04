set(LIBOMP_ENABLE_SHARED OFF)
set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
set(BLA_STATIC ON)
set(BLA_PREFER_STATIC ON)
if(WIN32)
    set(CMAKE_FIND_LIBRARY_SUFFIXES .lib)
    set(LIBOMP_ENABLE_SHARED ON)
endif()
find_package(PkgConfig REQUIRED)
include(ExternalProject)
message(${CMAKE_CURRENT_BINARY_DIR}/openmp)
message(STATUS "BUILD ${BUILD_OPENMP}")
if (NOT BUILD_OPENMP)
    find_package(OpenMP QUIET)
    if (OpenMP_FOUND)
        message(STATUS "${OpenMP_INCLUDE_DIRS}")
        add_library(openmp INTERFACE IMPORTED GLOBAL)
        add_dependencies(openmp OpenMP)
        target_link_libraries(openmp INTERFACE openmp)
    else()
        set(BUILD_OPENMP OFF)
    endif()
endif ()
if (BUILD_OPENMP)
    ExternalProject_Add(llvm_openmp
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/llvm-min/openmp
        PREFIX ${CMAKE_CURRENT_BINARY_DIR}/openmp
        CMAKE_ARGS
            -GNinja
            -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            -DCMAKE_BUILD_TYPE=Release
            -DLIBOMP_ENABLE_SHARED=OFF
            -DLIBOMP_FORTRAN_MODULES=ON
            -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/openmp

        BUILD_BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/openmp/src/llvm_openmp-build/runtime/src/libgomp.a
    )
    add_library(openmp INTERFACE IMPORTED GLOBAL)
    add_dependencies(openmp llvm_openmp)
    target_link_libraries(openmp INTERFACE openmp)
    target_include_directories(
        openmp INTERFACE
          ${CMAKE_CURRENT_BINARY_DIR}/openmp/include
    )
endif()


if(NOT (WIN32 OR WINDOWS_CROSS_COMPILE))
    find_package(chemfiles QUIET)
    if(NOT chemfiles_FOUND)
        if (NOT FROM_SOURCE_DEPENDENCIES)

            CPMAddPackage(
                NAME chemfiles
                VERSION "0.10.4"
                GIT_TAG "0.10.4"
                URL "https://github.com/chemfiles/chemfiles-prebuilt/releases/download/v0.10.4/chemfiles-static.v0.10.4.x86_64-linux-gnu.tar.gz"
            )
            if (chemfiles_ADDED)
                add_library(chemfiles STATIC IMPORTED GLOBAL)
            endif ()
        else ()
            CPMAddPackage(
                NAME chemfiles
                GITHUB_REPOSITORY "chemfiles/chemfiles"
                VERSION "0.10.4"
                GIT_TAG "0.10.4"
                OPTIONS
                    "CMAKE_BUILD_TYPE release"
                    "BUILD_SHARED_LIBS ON"
                    "CMAKE_C_FLAGS -Wno-error=implicit-function-declaration"
                    "CMAKE_CXX_FLAGS -Wno-error=implicit-function-declaration"
            )
        endif ()
    endif()
endif()
if((WIN32 OR WINDOWS_CROSS_COMPILE))
    add_library(chemfiles STATIC IMPORTED GLOBAL)
    set_target_properties(chemfiles PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/Lib/chemfiles.lib
    )
endif()
#target_include_directories(chemfiles INTERFACE "${mdspan_SOURCE_DIR}/include")

CPMAddPackage(
    NAME mdspan
    GITHUB_REPOSITORY "kokkos/mdspan"
    VERSION "0.6.0"
    GIT_TAG "74036ad3f253001fcf37b167067c0f4d57a17175"
    DOWNLOAD_ONLY YES
)

if(mdspan_ADDED)
    add_library(mdspan INTERFACE IMPORTED GLOBAL)
    target_include_directories(mdspan INTERFACE "${mdspan_SOURCE_DIR}/include")
endif()

message(STATUS "openblas source:${openblas_SOURCE_DIR}, Binary ${openblas_BINARY_DIR} include ${OpenBLAS_INCLUDE_DIR}")
if (NOT FROM_SOURCE_DEPENDENCIES)
    set(BUILD_OPENBLAS ON)
    find_package(OpenBLAS QUIET)
    if (NOT openblas_FOUND)
        find_package(BLAS )
        if(BLAS_FOUND)
            add_library(BLAS STATIC IMPORTED GLOBAL)
            message(STATUS "BLAS LIB: ${BLAS_LIBRARIES}")
            find_path(BLAS_INCLUDE_DIRS cblas.h
                PATHS
                    /usr/include
                    /usr/local/include
                    PATH_SUFFIXES openblas blas
                )
            message(STATUS "INCLUDES ${BLAS_INCLUDE_DIRS}")
            list(GET BLAS_LIBRARIES 0 BLAS_MAIN_LIB)
            set_target_properties(BLAS PROPERTIES
                IMPORTED_LOCATION "${BLAS_MAIN_LIB}"
                INTERFACE_INCLUDE_DIRECTORIES "${BLAS_INCLUDE_DIRS}"
                INTERFACE_LINK_LIBRARIES "${BLAS_LIBRARIES}"
            )
            add_library(openblas ALIAS BLAS)
            set(openblas_FOUND TRUE)
            set(openblas_LIBRARIES ${BLAS_LIBRARIES})
            set(openblas_INCLUDE_DIRS ${BLAS_INCLUDE_DIRS})
            set(BUILD_OPENBLAS OFF)
        endif()
    endif ()
endif ()

if (BUILD_OPENBLAS)
    CPMAddPackage(
        NAME openblas
        GITHUB_REPOSITORY "OpenMathLib/OpenBLAS"
        VERSION "0.3.29"
        GIT_TAG "v0.3.29"
        DOWNLOAD_ONLY YES
    )

    if (NOT "${CMAKE_Fortran_COMPILER}")
        set(CMAKE_Fortran_COMPILER "gfortran")
        if (WINDOWS_CROSS_COMPILE)
            set(CMAKE_Fortran_COMPILER "flang-new")
        endif()
    endif()
    if(NOT (WIN32 OR WINDOWS_CROSS_COMPILE))
        set(BLAS_MAKE_PARS 'CC="x86_64-w64-mingw32-gcc -Bstatic" FC="x86_64-w64-mingw32-gfortran -static-libgfortran"
          TARGET=HASWELL BINARY=${CMAKE_BUILD_PARALLEL_LEVEL} CROSS=1 NUM_THREADS=20 CONSISTENT_FPCSR=1 HOSTCC=gcc')
        if(openblas_ADDED)
            ExternalProject_Add(
              OpenBLAS
              SOURCE_DIR ${openblas_SOURCE_DIR}
              DEPENDS openmp
              BUILD_IN_SOURCE ON
              INSTALL_COMMAND make install PREFIX=${CMAKE_BINARY_DIR}/3rdparty/openblas
              BUILD_COMMAND make FC=${CMAKE_Fortran_COMPILER} USE_OPENMP=1 -j
              BUILD_BYPRODUCTS ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a
              LOG_BUILD ON
            )
            # Create imported target
            add_library(openblas STATIC IMPORTED GLOBAL)
            add_dependencies(openblas OpenBLAS)
            set_target_properties(openblas PROPERTIES
                IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a
            )
        endif ()
    else()
        ExternalProject_Add(
            OpenBLAS
            SOURCE_DIR ${openblas_SOURCE_DIR}
            DEPENDS openmp
            BUILD_IN_SOURCE ON
            INSTALL_COMMAND make install PREFIX=${CMAKE_BINARY_DIR}/3rdparty/openblas
            BUILD_COMMAND make FC=${CMAKE_Fortran_COMPILER} USE_OPENMP=1 -j
            BUILD_BYPRODUCTS ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a
            LOG_BUILD ON
        )
            # Create imported target
            add_library(openblas STATIC IMPORTED GLOBAL)
            add_dependencies(openblas OpenBLAS)
            set_target_properties(openblas PROPERTIES
                IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a
            )

    endif()

endif()
