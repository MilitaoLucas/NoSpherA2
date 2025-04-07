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
        set(OPENMP_LIBRARY ${OpenMP_gomp_LIBRARY} PARENT_SCOPE)
    else()
        set(BUILD_OPENMP ON)
    endif()
endif ()
message(STATUS "BUILD OPENMP: ${BUILD_OPENMP}")
if (BUILD_OPENMP AND (NOT WIN32))
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
    set(OPENMP_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/openmp/src/llvm_openmp-build/runtime/src/libomp.a PARENT_SCOPE)
    if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        set(OpenMP_CXX_FLAGS "-fopenmp=libomp" PARENT_SCOPE)
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(OpenMP_CXX_FLAGS "-fopenmp" PARENT_SCOPE)
    endif ()

endif()

if (WIN32 OR WINDOWS_CROSS_COMPILE)
    set(OpenMP_CXX_FLAGS "" PARENT_SCOPE)
endif ()
if(NOT (WIN32 OR WINDOWS_CROSS_COMPILE))
    find_package(chemfiles QUIET)
    if(NOT chemfiles_FOUND)
        if (NOT FROM_SOURCE_DEPENDENCIES)
            CPMAddPackage(
                NAME chemfiles
                VERSION "0.10.4"
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
if ((NOT FROM_SOURCE_DEPENDENCIES) AND (NOT BUILD_OPENBLAS))
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
              OpenBLAS
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
            NAME OpenBLAS
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
        file(MAKE_DIRECTORY "${DESTINATION_INCLUDE_DIR}")
        file(COPY "${openblas_SOURCE_DIR}/lapack-netlib/CBLAS/include/"
             DESTINATION "${DESTINATION_INCLUDE_DIR}")
        file(COPY "${openblas_SOURCE_DIR}/lapack-netlib/LAPACKE/include/"
             DESTINATION "${DESTINATION_INCLUDE_DIR}")
        file(COPY "${openblas_SOURCE_DIR}/cblas.h" DESTINATION "${DESTINATION_INCLUDE_DIR}") # THIS IS NEEDED TO BE AFTER THE ABOVE
        set(OPENBLAS_INCLUDE_DIR ${DESTINATION_INCLUDE_DIR} PARENT_SCOPE)
    endif()
endif()
if (NOT FROM_SOURCE_DEPENDENCIES)
    if (WIN32)
        set(METATENSOR_LIB metatensor.lib)
    elseif (DARWIN)
        set(METATENSOR_LIB libmetatensor_Mac.a)
    else ()
        set(METATENSOR_LIB libmetatensor.a)
    endif ()
    add_library(metatensor STATIC IMPORTED GLOBAL)
    set_target_properties(metatensor PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/Lib/${METATENSOR_LIB}
    )
else ()
    CPMAddPackage(
        NAME metatensor
        GITHUB_REPOSITORY "metatensor/metatensor"
        VERSION "v0.1.12"
        GIT_TAG "metatensor-core-v0.1.12"
        OPTIONS
            "CMAKE_BUILD_TYPE Release"
            "BUILD_SHARED_LIBS OFF"
            "METATENSOR_INSTALL_BOTH_STATIC_SHARED OFF"
    )
endif ()

# As rascaline was renamed, for now there will be no option to build from source
# For now, as rascaline header files are in the Src directory, I will just add the imported location
if (WIN32)
    set(RASCALINE_LIB rascaline.lib)
elseif (DARWIN)
    set(RASCALINE_LIB librascaline_mac.a)
else ()
    set(RASCALINE_LIB librascaline.a)
endif ()
add_library(rascaline STATIC IMPORTED GLOBAL)
set_target_properties(rascaline PROPERTIES
    IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/Lib/${RASCALINE_LIB}
)
