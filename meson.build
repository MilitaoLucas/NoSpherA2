project('NospherA2', 'cpp',
        default_options : ['warning_level=3',
                           'cpp_std=c++17', 
                           'default_library=static']
        )

inc_dirs = include_directories('Src')

# Source files
src_files = [
  'Src/AtomGrid.cpp',
  'Src/atoms.cpp',
  'Src/basis_set.cpp',
  'Src/cart2sph.cpp',
  'Src/constants.cpp',
  'Src/convenience.cpp',
  'Src/cube.cpp',
  'Src/ECPs_corrections.cpp',
  'Src/fchk.cpp',
  'Src/hdf5.cpp',
  'Src/int_g2e.cpp',
  'Src/int_optimizer.cpp',
  'Src/integration_params.cpp',
  'Src/integrator.cpp',
  'Src/isosurface.cpp',
  'Src/JKFit.cpp',
  'Src/libCintMain.cpp',
  'Src/mat_nos_math.cpp',
  'Src/molecule.cpp',
  'Src/nos_math.cpp',
  'Src/NoSpherA2.cpp',
  'Src/pch.cpp',
  'Src/properties.cpp',
  'Src/rys_roots.cpp',
  'Src/SALTED.cpp',
  'Src/SALTED_equicomb.cpp',
  'Src/SALTED_io.cpp',
  'Src/SALTED_predictor.cpp',
  'Src/SALTED_utilities.cpp',
  'Src/scattering_factors.cpp',
  'Src/sphere_lebedev_rule.cpp',
  'Src/spherical_density.cpp',
  'Src/unity.cpp',
  'Src/vec_nos_math.cpp',
  'Src/wfn_class.cpp'
]

# Dependencies
openmp_dep = dependency('openmp', required : true, static: true)
#openblas_dep = dependency('openblas', static : true)

metatensor_dep = dependency('metatensor', required: false)
if not metatensor_dep.found()
  cmake = import('cmake')
  sub_proj = cmake.subproject(
    'metatensor',
    # Set option for static library as you wanted
    cmake_options: ['-DBUILD_SHARED_LIBS=OFF']
  )

  # --- Add this line ---
  message('CMake targets found by Meson:\n - ' + '\n - '.join(sub_proj.target_list()))
  # ---------------------

  cargo_target = sub_proj.target('cargo-build-metatensor')
  inc_dir = include_directories(join_paths('subprojects', 'metatensor-core-cxx-0.1.12', '__CMake_build', 'include'))
  metatensor_dep = declare_dependency(
    include_directories: inc_dir,
    link_with : cargo_target
  )
endif
# Build executable
executable('NoSpherA2',
           src_files,
           include_directories : inc_dirs,
           dependencies : [openmp_dep, metatensor_dep],
           #dependencies : [openmp_dep, openblas_dep, metatensor_dep],
           install : true)

# Tests
# test_exe = executable('test_nosphera2', 'tests/main.cpp',
#                      include_directories : inc_dirs)
# test('basic', test_exe)
