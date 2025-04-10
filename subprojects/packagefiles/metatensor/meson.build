project(
  'metatensor',
  'cpp',
  version: '0.1.12',
  license: 'BSD-3',
  meson_version: '>=0.60.0',
)

includes = include_directories(['include'])

install_headers(
  ['include/metatensor.h', 
    'include/metatensor.hpp'],
  subdir: 'metatensor',
)

metatensor_dep = declare_dependency(
  include_directories: includes,
)

conf_data = configuration_data()
conf_data.set('CMAKE_INSTALL_PREFIX', get_option('prefix'))
conf_data.set('CMAKE_INSTALL_INCLUDEDIR', get_option('includedir'))
conf_data.set('PROJECT_NAME', meson.project_name())
conf_data.set('PROJECT_DESCRIPTION', 'A single header argument parser for C++17')
conf_data.set('PROJECT_VERSION', meson.project_version())
conf_data.set('CMAKE_BUILD_TYPE', 'release')
conf_data.set('BUILD_SHARED_LIBS', false)
conf_data.set('METATENSOR_INSTALL_BOTH_STATIC_SHARED', false)

