CPMAddPackage(
    NAME openblas
    GITHUB_REPOSITORY "OpenMathLib/OpenBLAS"
    VERSION "0.3.29"
    GIT_TAG "a64b75a2e00691b126a3c342a265f96fac98514f"
)

CPMAddPackage(
    NAME mdspan
    GITHUB_REPOSITORY "kokkos/mdspan"
    VERSION "0.6.0"
    GIT_TAG "74036ad3f253001fcf37b167067c0f4d57a17175"
)
if(openblas_ADDED)
    add_library(lapacke INTERFACE IMPORTED GLOBAL)
    target_include_directories(lapacke INTERFACE ${openblas_SOURCE_DIR}/lapack-netlib/LAPACKE/include)
    add_library(cblas INTERFACE IMPORTED GLOBAL)
    target_include_directories(cblas INTERFACE ${openblas_SOURCE_DIR}/lapack-netlib/CBLAS/include)
    add_library(openblas::openblas INTERFACE IMPORTED GLOBAL)
    target_include_directories(openblas::openblas INTERFACE ${openblas_BINARY_DIR}/lib)
endif()

#if(mdspan_ADDED)
#    add_library(mdspan::mdspan INTERFACE IMPORTED GLOBAL)
#    target_include_directories(mdspan INTERFACE ${mdspan_SOURCE_DIR}/include)
#endif()
