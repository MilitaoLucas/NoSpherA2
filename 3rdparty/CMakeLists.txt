set(OpenBLAS_INCLUDE_DIR "${CMAKE_CURRENT_BINARY_DIR}/include")
file(MAKE_DIRECTORY ${OpenBLAS_INCLUDE_DIR})
message(STATUS "openblas source: ${OpenBLAS_INCLUDE_DIR}")
CPMAddPackage(
    NAME openblas
    GITHUB_REPOSITORY "OpenMathLib/OpenBLAS"
    VERSION "0.3.29"
    GIT_TAG "a64b75a2e00691b126a3c342a265f96fac98514f"
    OPTIONS
      "BUILD_SHARED_LIBS OFF"
      "DYNAMIC_ARCH OFF"
      "BUILD_TESTING OFF"
      "CMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/openblas_install"
      "CMAKE_INSTALL_INCLUDEDIR=${OpenBLAS_INCLUDE_DIR}"
)

CPMAddPackage(
    NAME mdspan
    GITHUB_REPOSITORY "kokkos/mdspan"
    VERSION "0.6.0"
    GIT_TAG "74036ad3f253001fcf37b167067c0f4d57a17175"
)
    message(STATUS "openblas source:${CMAKE_CURRENT_BINARY_DIR} cm ${OpenBLAS_INCLUDE_DIR}")

if(openblas_ADDED)
  add_library(openblas ALIAS openblas_static)

  # Manually set include directories (if needed)
  target_include_directories(openblas_static INTERFACE
    $<BUILD_INTERFACE:${OpenBLAS_INCLUDE_DIR}>
  )

endif()

#if(mdspan_ADDED)
#    add_library(mdspan::mdspan INTERFACE IMPORTED GLOBAL)
#    target_include_directories(mdspan INTERFACE ${mdspan_SOURCE_DIR}/include)
#endif()
