# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-src")
  file(MAKE_DIRECTORY "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-src")
endif()
file(MAKE_DIRECTORY
  "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-build"
  "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-subbuild/unordered_dense-populate-prefix"
  "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-subbuild/unordered_dense-populate-prefix/tmp"
  "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-subbuild/unordered_dense-populate-prefix/src/unordered_dense-populate-stamp"
  "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-subbuild/unordered_dense-populate-prefix/src"
  "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-subbuild/unordered_dense-populate-prefix/src/unordered_dense-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-subbuild/unordered_dense-populate-prefix/src/unordered_dense-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/runner/work/NoSpherA2/NoSpherA2/build/_deps/unordered_dense-subbuild/unordered_dense-populate-prefix/src/unordered_dense-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
