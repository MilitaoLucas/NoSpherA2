set(LIBOMP_ENABLE_SHARED OFF)
if(WIN32 OR WINDOWS_BUILD)
    set(LIBOMP_ENABLE_SHARED ON)
endif()
include(ExternalProject)
message(${CMAKE_CURRENT_BINARY_DIR}/openmp)
message("TEST WIN ASSEMBLY: ${CMAKE_ASM_MASM_COMPILER}")
ExternalProject_Add(llvm_openmp
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/llvm-min/openmp
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/openmp
    CMAKE_ARGS
    -GNinja
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_BUILD_TYPE=Release
    -DLIBOMP_ENABLE_SHARED=${LIBOMP_ENABLE_SHARED}
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    -DCMAKE_ASM_MASM_COMPILER=${CMAKE_ASM_MASM_COMPILER}
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
CPMAddPackage(
    NAME openblas
    GITHUB_REPOSITORY "OpenMathLib/OpenBLAS"
    VERSION "0.3.29"
    GIT_TAG "v0.3.29"
    DOWNLOAD_ONLY YES

)
#CPMAddPackage(
#    NAME metatensor
#    GITHUB_REPOSITORY "metatensor/metatensor"
#    VERSION "v0.1.12"
#    GIT_TAG "metatensor-core-v0.1.12"
#    OPTIONS
#        "CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE}"
#        "BUILD_SHARED_LIBS OFF"
#        "METATENSOR_INSTALL_BOTH_STATIC_SHARED OFF"
#)

CPMAddPackage(
    NAME rascaline
    GITHUB_REPOSITORY "andreagrisafi/rascaline"
    VERSION "0.1.0"
    GIT_TAG "b3e095b5f7219d269020b220470406337b4ccfc7"
    OPTIONS
        "CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE}"
        "BUILD_SHARED_LIBS OFF"
        "METATENSOR_INSTALL_BOTH_STATIC_SHARED OFF"
)
if(NOT (WIN32 OR WINDOWS_BUILD))
    find_package(chemfiles QUIET)
    if(NOT chemfiles_FOUND)
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
    endif()
endif()
if((WIN32 OR WINDOWS_BUILD))
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
message(STATUS "openblas source:${openblas_SOURCE_DIR}, Binary ${openblas_BINARY_DIR} include ${OpenBLAS_INCLUDE_DIR}")
if (NOT "${CMAKE_Fortran_COMPILER}")
    set(CMAKE_Fortran_COMPILER "gfortran")
    if (WINDOWS_BUILD)
        set(CMAKE_Fortran_COMPILER "flang-new")
    endif()
endif()
if(openblas_ADDED)
    include(ExternalProject)
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
    add_dependencies(openblas OpenBLAS )
    set_target_properties(openblas PROPERTIES
        IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a
    )

endif()


if(metatensor_ADDED)
    add_library(metatensor::metatensor STATIC IMPORTED GLOBAL)
    add_dependencies(metatensor::metatensor metatensor)
    set_target_properties(metatensor::metatensor PROPERTIES
        IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/_deps/metatensor-build/metatensor-core/target/debug/libmetatensor.a
    )
endif()

if(rascaline_ADDED)
    add_library(rascaline::rascaline STATIC IMPORTED GLOBAL)
    add_dependencies(rascaline::rascaline rascaline)
    set_target_properties(rascaline::rascaline PROPERTIES
        IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/_deps/rascaline-build/rascaline-core/target/debug/librascaline.a
    )
endif()
if(mdspan_ADDED)
    add_library(mdspan INTERFACE IMPORTED GLOBAL)
    target_include_directories(mdspan INTERFACE "${mdspan_SOURCE_DIR}/include")
endif()
