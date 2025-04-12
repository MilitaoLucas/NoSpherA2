project(
  'lapacke',
  'c',
  # Get version from somewhere (e.g., file, git tag, parent project)
  version: '0.3.29',
  license: 'BSD-3-Clause', # Specify your license
  meson_version: '>= 0.60.0', # Recommended minimum version
  default_options: ['c_std=c99'],
)

lapacke_name = meson.project_name()
lapacke_version = meson.project_version()
lapacke_major_version = lapacke_version.split('.')[0]

# Get compilers and system info
cc = meson.get_compiler('c')
host_system = host_machine.system()

# --- Get Options ---
build_single = get_option('LAPACKE_BUILD_SINGLE')
build_double = get_option('LAPACKE_BUILD_DOUBLE')
build_complex = get_option('LAPACKE_BUILD_COMPLEX')
build_complex16 = get_option('LAPACKE_BUILD_COMPLEX16')
build_testing = get_option('tests')

message('LAPACKE Configuration:')
message('  Version:                    ', lapacke_version)
message('  Build single precision:     ', build_single)
message('  Build double precision:     ', build_double)
message('  Build complex precision:    ', build_complex)
message('  Build complex*16 precision: ', build_complex16)
message('  Build tests/examples:       ', build_testing)

# --- Dependencies ---
# Need underlying Fortran LAPACK and BLAS
# Allow fallback to subproject if not found on system
lapack_dep = dependency('lapack', fallback: ['lapack', 'lapack_dep'])
blas_dep = dependency('blas', fallback: ['lapack', 'blas_dep']) # Often BLAS comes with LAPACK

# Dependency for TMG library if needed
# --- Configure Headers ---
# Generate lapacke_mangling.h using the fallback configure_file approach
# This avoids replicating the complex CMake FortranCInterface checks.
conf_data = configuration_data()
# Add any necessary definitions based on checks if needed for the .h.in file
# Example check (may not be needed depending on the .h.in file):
# conf_data.set('LAPACK_GLOBAL_PATTERN_POST', '_') # Or based on cc properties
lapacke_mangling_h = configure_file(
  input: 'include/lapacke_mangling_with_flags.h.in',
  output: 'lapacke_mangling.h',
  configuration: conf_data,
  # Install the generated header alongside others
  install_dir: join_paths(get_option('includedir'), lapacke_name),
)

# Include directories: source 'include' and the build directory for generated headers
inc_dirs = include_directories('include', '.')

# --- Collect Source Files ---
# These variables should be defined in the meson.build files of the subdirectories
sources_common = []
sources_single = []
sources_double = []
sources_complex = []
sources_complex16 = []
sources_deprecated = []
sources_extended = [] # for XBLAS
sources_matgen = [] # for TMG
sources_utils = []

# Process subdirectories (they should add sources to the lists above)
subdir('src')
subdir('utils')

# Combine sources based on options
lapacke_sources = sources_common
#message('build_single: -', sources_common)
if build_single
  lapacke_sources += sources_single
endif
if build_double
  lapacke_sources += sources_double
endif
if build_complex
  lapacke_sources += sources_complex
endif
if build_complex16
  lapacke_sources += sources_complex16
endif
lapacke_sources += sources_utils

# --- Platform Specific Configuration ---
c_args = []
link_args = []
compile_defs = {}

if host_system == 'windows'
  message('Applying Windows-specific configuration')
  # Define these for users of the library via pkg-config/CMake export
  compile_defs = {
    'HAVE_LAPACK_CONFIG_H': 1,
    'LAPACK_COMPLEX_STRUCTURE': 1,
  }
  # Meson handles DLL export/import automatically for library() targets usually
endif

# Corrected code block structure (Preferred Method)
lapackelib = library(
  lapacke_name, # Arg 1: name
  lapacke_sources,
  version: lapacke_version,
  soversion: lapacke_major_version,
  install: true,
  include_directories: inc_dirs,
  # Add internal dependencies (lapacke_src_dep, etc.) to this list:
  # link_with: [ ... ], # <<-- REMOVED deprecated line
  c_args: c_args,
  link_args: link_args,
  # Ensure last argument has a comma if the ')' is on the next line, or no comma if ')' is on this line.
)

c_compile_args = []
foreach k, v : compile_defs
  # Note: Meson foreach on dict iterates key, value directly
  # Note: Ensure value 'v' is string or convertable (like integer 1)
  c_compile_args += ['-D' + k + '=' + v.to_string()]
endforeach

# Now use the generated list in declare_dependency
lapackelib_dep = declare_dependency(
  link_with: lapackelib,
  include_directories: [inc_dirs], # Adjust includes as needed based on previous method
  # Use the list created above:
  compile_args: c_compile_args,
  dependencies: [lapack_dep, blas_dep] # Underlying deps,,,,,,,
)
# --- Installation ---
# Install public headers from the 'include' directory
# Assumes standard LAPACKE headers are present
install_headers(
  'include/lapack.h',
  'include/lapacke.h',
  'include/lapacke_config.h', # If it exists and is static
  'include/lapacke_utils.h',
  # Add any other public headers here
  subdir: lapacke_name # Install path: ${prefix}/include/lapacke/,,,,,,,,,,,,,,,,,,,,,,
)
# lapacke_mangling.h is installed via configure_file() install_dir parameter above

# Generate and install CMake package files (*-config.cmake, *-config-version.cmake)
# This uses Meson's built-in generator. For custom logic from .in files,
# you would use configure_file manually.
#cmake = import('cmake')
#cmake.configure_package_config_file(
#  name: lapacke_name,
#  input: 'cmake/lapacke-config.cmake.in', # Your template
#  configuration: configuration_data(
#    {
#      # Variables for the template
#      'PACKAGE_VERSION': lapacke_version,
#      'LAPACKE_INCLUDE_DIRS': '${PACKAGE_PREFIX_DIR}/' + get_option('includedir'),
#      'LAPACKE_LIBRARIES': lapacke_name, # Or link flags if needed
#      # Add other variables needed by your CMake config template
#    },
#  ),
#  install_dir: join_paths(get_option('libdir'), 'cmake', lapacke_name),
#)

configure_file(
  input: 'cmake/lapacke-config-version.cmake.in', # Your template
  output: '@BASENAME@',
  configuration: configuration_data(
    {
      # Variables for the template
      'PACKAGE_VERSION': lapacke_version,
    },
  ),
  install_dir: join_paths(get_option('libdir'), 'cmake', lapacke_name),
)

# --- Build Tests/Examples ---
if build_testing
  subdir('example') # Assuming examples are in 'example/'
endif
