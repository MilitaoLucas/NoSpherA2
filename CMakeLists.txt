cmake_minimum_required(VERSION 3.14)
project(NoSpherA2 CXX C)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_GENERATOR "Ninja" CACHE INTERNAL "")
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(BUILD_DIR ${CMAKE_SOURCE_DIR}/build)
set(DEBUG_DIR ${CMAKE_SOURCE_DIR}/build_debug)

if(WIN32)
    set(NAME "WINDOWS")
elseif(APPLE)
    set(NAME "MAC")
elseif(UNIX)
    set(NAME "LINUX")
endif()

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

ExternalProject_Add(compiler-rt
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/llvm-min/compiler-rt
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/compiler-rt
  CMAKE_ARGS
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_BUILD_TYPE=Release
    -DLIBOMP_ENABLE_SHARED=OFF
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/3rdparty/compiler-rt
    -DLIBOMP_INSTALL_ALIASES=OFF
  BUILD_BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/lib/libomp.a
)
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
  BUILD_BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/lib/libomp.a
)

set(OPENMP_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/include)
set(OPENMP_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/lib/libomp.a)

include_directories(
    ${OPENMP_INCLUDE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/Lib
    ${CMAKE_CURRENT_SOURCE_DIR}/Src
)
# Include directories
include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/Lib
  ${CMAKE_CURRENT_SOURCE_DIR}/Src
)

# Find OpenBLAS
find_package(OpenBLAS QUIET)
if(NOT OpenBLAS_FOUND)
  message(STATUS "Using OpenBLAS from CPM")
endif()

# Add executable
add_executable(NoSpherA2 ${SOURCE_FILES})

# Set compile definitions
target_compile_definitions(NoSpherA2 PRIVATE
  $<$<CONFIG:Debug>:DEBUG>
  $<$<CONFIG:Release>:NDEBUG>
)

# Set compile options
target_compile_options(NoSpherA2 PRIVATE
  $<$<CONFIG:Debug>:-g>
  $<$<CONFIG:Release>:-O3>
)

# Add dependencies
add_dependencies(NoSpherA2 llvm_openmp)

# Link libraries
target_link_libraries(NoSpherA2 PRIVATE
  ${OpenBLAS_LIBRARIES}
  ${OPENMP_LIBRARY}
  mdspan
)

# Set output directories
set_target_properties(NoSpherA2 PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}
  RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_SOURCE_DIR}
  RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}
  OUTPUT_NAME_DEBUG "NoSpherA2_Debug"
)

# Install targets
install(TARGETS NoSpherA2
  RUNTIME DESTINATION bin
)
