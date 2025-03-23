CPMAddPackage(
    NAME openblas
    GITHUB_REPOSITORY "OpenMathLib/OpenBLAS"
    VERSION "0.3.29"
    GIT_TAG "a64b75a2e00691b126a3c342a265f96fac98514f"
    DOWNLOAD_ONLY YES

)

CPMAddPackage(
    NAME mdspan
    GITHUB_REPOSITORY "kokkos/mdspan"
    VERSION "0.6.0"
    GIT_TAG "74036ad3f253001fcf37b167067c0f4d57a17175"
    OPTIONS "MDSPAN_CXX_STANDARD 23"
      "MDSPAN_USE_PAREN_OPERATOR 1"
      "MDSPAN_ENABLE_CONCEPTS ON"
)
    message(STATUS "openblas source:${openblas_BINARY_DIR} cm ${OpenBLAS_INCLUDE_DIR}")

if(openblas_ADDED)
    include(ExternalProject)
    # Build openblas with LAPACK
    ExternalProject_Add(
      OpenBLAS
      SOURCE_DIR ${openblas_SOURCE_DIR}
      CMAKE_ARGS
        -GNinja
        -DBUILD_SHARED_LIBS=OFF
        -DBUILD_BENCHMARKS=OFF
        -DBUILD_TESTING=OFF
        -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/3rdparty/openblas
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
        -DCMAKE_BUILD_TYPE=Release
      BUILD_BYPRODUCTS ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib64/libopenblas.a
      LOG_BUILD ON
    )

    # Create imported target
    add_library(openblas STATIC IMPORTED GLOBAL)
    add_dependencies(openblas OpenBLAS)
    set_target_properties(openblas PROPERTIES
        IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/3rdparty/openblas/lib64/libopenblas.a
    )

endif()


if(mdspan_ADDED)
    add_library(mdspan::mdspan INTERFACE IMPORTED GLOBAL)
    target_include_directories(mdspan INTERFACE ${mdspan_SOURCE_DIR}/include)
    target_compile_features(mdspan INTERFACE cxx_std_23)
    target_compile_definitions(mdspan INTERFACE MDSPAN_USE_PAREN_OPERATOR=1)
endif()
