project('rascaline', 'cpp')

rascaline_inc = include_directories('include')
rascaline_lib = meson.get_compiler('cpp').find_library(
  'rascaline',
  dirs: meson.current_source_dir(), # looks for librascaline.a here
  static: true # enforce static linking,,
)

rascaline_dep = declare_dependency(dependencies: rascaline_lib, include_directories: rascaline_inc)