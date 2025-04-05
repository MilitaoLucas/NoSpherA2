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

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    option(BUILD_TESTING "Run tests" OFF)
    option(FROM_SOURCE_DEPENDENCIES "BUILD EVERY DEPENDENCY FROM SOURCE" OFF)
    option(WINDOWS_CROSS_COMPILE "CROSS COMPILING TO WINDOWS" OFF)
    option(BUILD_OPENMP "Necessary if cross compiling from windows to Linux/Darwin" OFF)
endif()
if(WINDOWS_CROSS_COMPILE)
    if(FROM_SOURCE_DEPENDENCIES)
        message(WARNING "From source dependencies are currently disabled for cross-compilation.")
    endif()
    set(FROM_SOURCE_DEPENDENCIES OFF)
endif()
if (FROM_SOURCE_DEPENDENCIES)
    set(BUILD_OPENMP ON)
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

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(BUILD_OPENMP ON)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(OPENMP_LIBRARY_LOCATION openmp)
endif ()
if(WIN32 OR WINDOWS_CROSS_COMPILE)
    message("windows!!! link")
    set(CMAKE_LINKER lld-link)
endif()
set(OPENMP_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/include)
#set(OPENMP_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openmp/src/llvm_openmp-build/runtime/src/libgomp.a)

add_subdirectory(3rdparty EXCLUDE_FROM_ALL)
set(OPENBLAS_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openblas/include)
set(OPENBLAS_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/openblas/lib/libopenblas.a)

set(MDSPAN_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/_deps/mdspan-src/include)
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/Src
    ${MDSPAN_INCLUDE_DIR}
    ${OPENMP_INCLUDE_DIR}
)

add_executable(NoSpherA2 ${SOURCE_FILES})

target_precompile_headers(NoSpherA2 PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/pch.h
)
if(BLAS_FOUND)
    set(LIB_BLAS BLAS::BLAS)
else ()
    set(LIB_BLAS openblas)
endif ()

add_dependencies(NoSpherA2 openmp openblas chemfiles)
target_compile_definitions(NoSpherA2 PRIVATE
    $<$<CONFIG:Debug>:DEBUG>
    $<$<CONFIG:Release>:NDEBUG>
)

message(WARNING ${OpenMP_CXX_FLAGS})
target_compile_options(NoSpherA2 PRIVATE
    $<$<CONFIG:Debug>:-g -Og>
    $<$<CONFIG:Release>:-O3>
    -static
    ${OpenMP_CXX_FLAGS}
    -MMD
    -MP
    -fmessage-length=0
)



target_link_options(NoSpherA2 PRIVATE
    -static
    -static-libgcc
    -static-libstdc++
)
if (${WINDOWS_CROSS_COMPILE} OR WIN32)
  message("DOING IT FOR WINDOWS" )
  set(LIB_ATOMIC "")
else()
  set(LIB_ATOMIC "-latomic")
endif()

target_link_libraries(NoSpherA2 PRIVATE
    mdspan
    metatensor
    rascaline
#    ${OPENMP_LIBRARY_FLAG}
    ${OpenMP_CXX_FLAGS}
#    openmp
    openblas
    -ldl
    -lpthread
    ${LIB_ATOMIC}
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
