project('metatensor', 
  'cpp',
  version: '0.1.12'
  )
cmake = import('cmake')

# Configure the CMake project
sub_proj = cmake.subproject('metatensor-core-cxx-0.1.12')

# Provide the library dependency
metatensor_dep = sub_proj.dependency('metatensor')

# Make the dependency available to the parent project
meson.override_dependency('metatensor', metatensor_dep)

