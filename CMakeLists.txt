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


set(OPENMP_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/include)
set(OPENMP_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/src/llvm_openmp-build/runtime/src/libgomp.a)

add_subdirectory(3rdparty EXCLUDE_FROM_ALL)
set(OPENBLAS_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openblas/include)
set(OPENBLAS_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a)

set(MDSPAN_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/_deps/mdspan-src/include)
include_directories(
    ${OPENBLAS_INCLUDE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/Src
    ${MDSPAN_INCLUDE_DIR}
)

add_executable(NoSpherA2 ${SOURCE_FILES})

target_precompile_headers(NoSpherA2 PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/pch.h
)
add_dependencies(NoSpherA2 llvm_openmp OpenBLAS chemfiles)
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



target_link_options(NoSpherA2 PRIVATE
    -static
    -static-libgcc
    -static-libstdc++
)

target_link_libraries(NoSpherA2 PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Lib/libmetatensor.a
    ${CMAKE_CURRENT_SOURCE_DIR}/Lib/librascaline.a
    openblas
    ${OPENMP_LIBRARY}
    -ldl
    -lpthread
    -latomic
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
