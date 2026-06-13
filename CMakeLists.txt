cmake_minimum_required(VERSION 3.15)
project(NoSpherA2 CXX C)
message(STATUS "CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
if(NO_TRIVIAL_INIT)
    add_compile_options(-ftrivial-auto-var-init=pattern)
endif()

if(WIN32)
    set(CMAKE_TRY_COMPILE_CONFIGURATION Release)
endif()

# Vector instruction policy. OCC and NoSpherA2 MUST be built with the same
# setting: Eigen object layouts differ between AVX and non-AVX builds, and
# mixing them across the static-link boundary causes crashes.
#   NOS_AVX=ON   build with AVX
#   NOS_AVX=OFF  SSE only — maximum compatibility, used by CI
#   unset        honor the NOS_AVX environment variable, else detect the host
if(NOT DEFINED NOS_AVX)
    if(DEFINED ENV{NOS_AVX} AND NOT "$ENV{NOS_AVX}" STREQUAL "")
        set(NOS_AVX "$ENV{NOS_AVX}")
    else()
        set(NOS_AVX "AUTO")
    endif()
endif()
set(NOS_USE_AVX OFF)
if(NOS_AVX STREQUAL "AUTO")
    if(NOT CMAKE_CROSSCOMPILING AND CMAKE_SYSTEM_PROCESSOR MATCHES "(x86_64|AMD64|amd64)")
        try_run(NOS_AVX_RUN_RESULT NOS_AVX_COMPILE_RESULT
            ${CMAKE_BINARY_DIR}/nos_avx_check
            ${CMAKE_CURRENT_SOURCE_DIR}/cmake/detect_avx.c)
        if(NOS_AVX_COMPILE_RESULT AND NOS_AVX_RUN_RESULT EQUAL 0)
            set(NOS_USE_AVX ON)
        endif()
    endif()
elseif(NOS_AVX)
    set(NOS_USE_AVX ON)
endif()
message(STATUS "NOS_AVX=${NOS_AVX} -> building with AVX: ${NOS_USE_AVX}")

if(LINUX)
    add_compile_options(
        -msse2
        -msse3
        -msse4.1
        -msse4.2
    )
    if(NOS_USE_AVX)
        add_compile_options(-mavx)
    endif()
endif()

if(WIN32 AND NOS_USE_AVX)
    add_compile_options(/arch:AVX)
endif()
set(BUILD_NOS_DOCS "OFF" CACHE BOOL "Build doxygen documentations.")
if(${BUILD_NOS_DOCS})
    find_package(Doxygen)
    if(DOXYGEN_FOUND)
        set(DOXYGEN_IN "${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in")
        set(DOXYGEN_OUT "${CMAKE_CURRENT_BINARY_DIR}/Doxyfile.out")
        configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
        message(STATUS "Start building documentation with Doxygen")
        add_custom_target(
            docs
            COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
            COMMENT "Generating documentation with Doxygen"
            VERBATIM
        )
    else(DOXYGEN_FOUND)
        message(STATUS "Doxygen must be installed to generate documentation")
    endif(DOXYGEN_FOUND)
endif()
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(BUILD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build)
set(DEBUG_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build_debug)
set(CMAKE_INSTALL_PREFIX
    $ENV{HOME}
    CACHE PATH
    "Install path prefix, prepended onto install directories."
)
message(STATUS "Install prefix: ${CMAKE_INSTALL_PREFIX}")

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    option(BUILD_TESTING "Run tests" ON)
    option(
        BUILD_RELEASE_OCC
        "Build OCC in release mode even if NoSpherA2 is built in Debug"
        OFF
    )
    option(FROM_SOURCE_DEPENDENCIES "BUILD EVERY DEPENDENCY FROM SOURCE" OFF)
    option(WINDOWS_CROSS_COMPILE "CROSS COMPILING TO WINDOWS" OFF)
    option(
        BUILD_OPENMP
        "Necessary if cross compiling from windows to Linux/Darwin"
        OFF
    )
    option(
        USE_VECTOR_INSTRUCTIONS
        "If you want to use vector instructions. Defaults to ON"
        ON
    )
    option(WITH_CLANG_TIDY "Enable clang tidy" OFF)
    if(NOT (CMAKE_SYSTEM_NAME STREQUAL "Darwin"))
        set(MKL_INTERFACE
            "lp64"
            CACHE STRING
            "ilp64 uses double precision for indices in MKL, the other option is lp64."
        )
        set(ONEAPI_DIRECTORY
            $ENV{MKLROOT}
            CACHE STRING
            "Location of OneAPI. If empty and you didn't loaded modules or used a setvars.sh, OneAPI will be downloaded."
        )
        set(FAKE_HOME_TEST
            "ON"
            CACHE STRING
            "This is for testing the automatic install of MKL. It pretends the home directory is at /tmp/home."
        )
    endif()
    set(CONDA_ENV "base" CACHE STRING "Conda env to be used.")
    set(CONDA_COMMAND
        "conda"
        CACHE STRING
        "CONDA command (used to download dependencies.)"
    )
    set(OCC_BUILD_TYPE "${CMAKE_BUILD_TYPE}" CACHE STRING "Build type for OCC")
    option(IS_ACTIONS "Building in GitHub Actions" OFF)
    option(USE_CUSTOM_ENV OFF)
    if(NOT CONDA_ENV STREQUAL "base")
        option(USE_CUSTOM_ENV "Use a user provided environment for conda." ON)
    endif()
    set(USE_SANITIZER
        ""
        CACHE STRING
        "Sanitizer to use: Address, Thread, or Memory (Only available in Debug mode)"
    )
endif()
if(
    NOT "${USE_SANITIZER}" STREQUAL ""
    AND NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Debug"
)
    message(
        FATAL_ERROR
        "Sanitizer should only be used in Debug mode. Without debug symbols it is really hard to know where the issue is."
    )
endif()

if(NOT "${USE_SANITIZER}" STREQUAL "" AND MSVC)
    message(
        FATAL_ERROR
        "Sanitizers configured via USE_SANITIZER are not supported with the MSVC toolchain in this project."
    )
endif()

if(USE_SANITIZER MATCHES "Address")
    add_compile_options(
        $<$<CONFIG:Debug>:-fsanitize=address,leak,undefined>
        $<$<CONFIG:Debug>:-fno-omit-frame-pointer>
        $<$<CONFIG:Debug>:-O0>
    )
    add_link_options($<$<CONFIG:Debug>:-fsanitize=address,leak,undefined>)
elseif(USE_SANITIZER MATCHES "Thread")
    add_compile_options(
        $<$<CONFIG:Debug>:-fsanitize=thread>
        $<$<CONFIG:Debug>:-fno-omit-frame-pointer>
        $<$<CONFIG:Debug>:-O0>
    )
    add_link_options($<$<CONFIG:Debug>:-fsanitize=thread>)
elseif(USE_SANITIZER MATCHES "Memory")
    add_compile_options(
        $<$<CONFIG:Debug>:-fsanitize=memory>
        $<$<CONFIG:Debug>:-fsanitize-memory-track-origins>
        $<$<CONFIG:Debug>:-fno-omit-frame-pointer>
        $<$<CONFIG:Debug>:-O0>
    )
    add_link_options($<$<CONFIG:Debug>:-fsanitize=memory>)
endif()

if(MSVC AND NOT ("${OCC_BUILD_TYPE}" STREQUAL "${CMAKE_BUILD_TYPE}"))
    message(
        FATAL_ERROR
        "Building OCC in a different mode than NoSpherA2 is not supported because MSVC containers have
            different sizes between Release and Debug builds."
    )
endif()

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
#include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/CPM.cmake")
if(NOT ONLY_OCC)
    add_subdirectory(3rdparty EXCLUDE_FROM_ALL)
endif()

# external dependencies
set(WITH_FORTRAN "OFF")
set(WITH_CINT2_INTERFACE "OFF")
set(ENABLE_STATIC "ON")
set(BUILD_SHARED_LIBS "OFF")
set(PYPZPX "ON")
set(WITH_RANGE_COULOMB "ON")
if(ONLY_OCC AND WIN32)
    set(libcint_IMPORTED_LOCATION
        "${CMAKE_CURRENT_SOURCE_DIR}/Lib/LibCint/lib/cint.lib"
    )
    if(EXISTS ${libcint_IMPORTED_LOCATION})
        message(
            STATUS
            "Using precompiled libcint from ${libcint_IMPORTED_LOCATION}"
        )
    else()
        message(
            FATAL_ERROR
            "You beed to run '.\\Windows\\Build_Dependencies\\build_deps.ps1 .'"
        )
    endif()
    add_library(cint STATIC IMPORTED)
    set_target_properties(
        cint
        PROPERTIES
            IMPORTED_LOCATION "${libcint_IMPORTED_LOCATION}"
            INTERFACE_INCLUDE_DIRECTORIES
                "${CMAKE_CURRENT_SOURCE_DIR}/Lib/LibCint/include"
    )
else()
    # Build libcint from the submodule so that `cint` is a real in-tree
    # target: BUILD_UNIFIED_LIB embeds $<TARGET_OBJECTS:cint> into libocc.a,
    # which is impossible for an IMPORTED prebuilt archive (the archiver
    # would store the whole libcint.a as a raw member, which ld64 rejects).
    add_subdirectory(libcint)
endif()

add_library(libcint::libcint INTERFACE IMPORTED GLOBAL)
target_link_libraries(libcint::libcint INTERFACE cint)
target_include_directories(
    libcint::libcint
    INTERFACE
        "${CMAKE_CURRENT_SOURCE_DIR}/libcint/include"
        "${CMAKE_CURRENT_SOURCE_DIR}/libcint/src"
)
set(USE_SYSTEM_LIBCINT "ON")
set(BUILD_FPIC "ON")
set(WITH_PYTHON_BINDINGS "OFF")
set(BUILD_SHARED_LIBS "FALSE")
if(NOT (CMAKE_SYSTEM_NAME STREQUAL "Darwin"))
    if(WIN32)
        set(Python3_EXECUTABLE ${MICROMAMBA_ENV_PATH}/python.exe)
        set(Python_EXECUTABLE ${MICROMAMBA_ENV_PATH}/python.exe)
    else()
        set(Python3_EXECUTABLE ${MICROMAMBA_ENV_PATH}/bin/python)
    endif()
endif()
add_subdirectory(occ)
if(ONLY_OCC)
    return()
endif()
add_subdirectory(mdspan)
set(FEATOMIC_FETCH_METATENSOR "ON")
set(BUILD_SHARED_LIBS "OFF")
set(FEATOMIC_INSTALL_BOTH_STATIC_SHARED "OFF")
set(FEATOMIC_USE_STATIC_METATENSOR "ON")
add_subdirectory(featomic/featomic)

add_subdirectory(BasisSetGenerator)
add_subdirectory(Src)
enable_testing()
add_subdirectory(tests)
