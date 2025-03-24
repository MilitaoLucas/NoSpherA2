cmake_minimum_required(VERSION 3.14)
project(NoSpherA2 CXX C)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(BUILD_DIR ${CMAKE_SOURCE_DIR}/build)
set(DEBUG_DIR ${CMAKE_SOURCE_DIR}/build_debug)
set(CMAKE_INSTALL_PREFIX $ENV{HOME})
message(STATUS "Install prefix: ${CMAKE_INSTALL_PREFIX}")
if(WIN32)
  set(NAME "WINDOWS")
elseif(APPLE)
  set(NAME "MAC")
elseif(UNIX)
  set(NAME "LINUX")
endif()

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    option(BUILD_TESTING "Run tests" OFF)
endif()
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-unique-section-names")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-gnu-unique")
endif()
message(STATUS "Using compiler: ${CMAKE_CXX_COMPILER_ID}")
set(SOURCE_FILES
    Src/wfn_class.cpp
    Src/atoms.cpp
    Src/properties.cpp
    Src/spherical_density.cpp
    Src/AtomGrid.cpp
    Src/basis_set.cpp
    Src/convenience.cpp
    Src/sphere_lebedev_rule.cpp
    Src/scattering_factors.cpp
    Src/cube.cpp
    Src/fchk.cpp
    Src/JKFit.cpp
    Src/NoSpherA2.cpp
    Src/SALTED_utilities.cpp
    Src/constants.cpp
    Src/ECPs_corrections.cpp
    Src/libCintMain.cpp
    Src/nos_math.cpp
    Src/SALTED_io.cpp
    Src/SALTED_predictor.cpp
    Src/SALTED_equicomb.cpp
    Src/isosurface.cpp
    Src/cart2sph.cpp
    Src/int_g2e.cpp
    Src/int_optimizer.cpp
    Src/integration_params.cpp
    Src/integrator.cpp
    Src/rys_roots.cpp
)
include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/CPM.cmake")
add_subdirectory(3rdparty EXCLUDE_FROM_ALL)
include(ExternalProject)
message(${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp)
ExternalProject_Add(llvm_openmp
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/llvm-min/openmp
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp
    CMAKE_ARGS
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_BUILD_TYPE=Release
    -DLIBOMP_ENABLE_SHARED=OFF
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp
    -DLIBOMP_INSTALL_ALIASES=OFF
    BUILD_BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/src/llvm_openmp-build/runtime/src/libgomp.a
)

set(OPENMP_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/include)
set(OPENMP_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/src/llvm_openmp-build/runtime/src/libgomp.a)

set(OPENBLAS_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openblas/include/openblas)
set(OPENBLAS_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openblas/lib64/libopenblas.a)

include_directories(
    ${OPENMP_INCLUDE_DIR}
    ${OPENBLAS_INCLUDE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/Src
    ${CMAKE_CURRENT_SOURCE_DIR}/Lib
)

add_executable(NoSpherA2 ${SOURCE_FILES})
add_dependencies(NoSpherA2 llvm_openmp openblas)
target_compile_definitions(NoSpherA2 PRIVATE
    $<$<CONFIG:Debug>:DEBUG>
    $<$<CONFIG:Release>:NDEBUG>
)


target_compile_options(NoSpherA2 PRIVATE
    $<$<CONFIG:Debug>:-g -Og>
    $<$<CONFIG:Release>:-O3>
    -fopenmp
    -static
    -MMD
    -MP
    -fmessage-length=0
)

target_precompile_headers(NoSpherA2 PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/pch.h
)

target_link_options(NoSpherA2 PRIVATE
    -static
    -static-libgcc
    -static-libstdc++
)

target_link_libraries(NoSpherA2 PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Lib/libmetatensor.a
    ${CMAKE_CURRENT_SOURCE_DIR}/Lib/librascaline.a
    ${OPENMP_LIBRARY}
    ${OPENBLAS_LIBRARY}
    mdspan
    openblas
    -ldl
    -lpthread
)

# Set output directories
set_target_properties(NoSpherA2 PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_CURRENT_BINARY_DIR}
    RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_CURRENT_BINARY_DIR}
)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME AND BUILD_TESTING)
    message(STATUS "Running tests")
    enable_testing()
    add_subdirectory(tests)
endif()
