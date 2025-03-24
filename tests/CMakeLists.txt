# Set minimum CMake version
cmake_minimum_required(VERSION 3.10)

# Find the required programs
find_program(DIFF_COMMAND NAMES diff fc)
find_program(MV_COMMAND NAMES mv move)

# Set platform-specific variables
if(WIN32)
  set(DIFF_ARGS "/c")
else()
  set(DIFF_ARGS "-q -i -b")
endif()


# Define a function to add NoSpherA2 tests
function(add_nosphera2_test name working_dir)
  add_test(
    NAME ${name}
    COMMAND ${CMAKE_COMMAND}
      -DEXECUTABLE=$<TARGET_FILE:NoSpherA2>
      -DWORKING_DIR=${CMAKE_CURRENT_SOURCE_DIR}/${working_dir}
      -DDIFF_COMMAND=${DIFF_COMMAND}
      -DDIFF_ARGS=${DIFF_ARGS}
      -DMV_COMMAND=${MV_COMMAND}
      -DTEST_NAME=${name}
      -DTEST_ARGS=${ARGN}
      -P ${CMAKE_CURRENT_SOURCE_DIR}/run_test.cmake
  )
  # Add dependency to ensure NoSpherA2 is built before running tests
  set_tests_properties(${name} PROPERTIES DEPENDS NoSpherA2)
endfunction()
# Add all the tests
add_nosphera2_test(sucrose_SF "sucrose_fchk_SF"
  -cif sucrose.cif
  -hkl olex2/Wfn_job/sucrose.hkl
  -wfn olex2/Wfn_job/sucrose.wfx
  -acc 0
  -no-date)

add_nosphera2_test(openBLAS "OpenBLAS"
  -blastest
  -no-date)

add_nosphera2_test(malbac_SF_ECP "ECP_SF"
  -cif malbac.cif
  -hkl malbac.hkl
  -wfn malbac.gbw
  -acc 0
  -ECP 1
  -no-date)

add_nosphera2_test(SALTED "SALTED"
  -SALTED Model
  -cif test_cysteine.cif
  -wfn test_cysteine.xyz
  -dmin 0.73
  -no-date)

add_nosphera2_test(reading_SALTED "SALTED"
  -test_reading_SALTED_binary)

add_nosphera2_test(sucrose_IAM "sucrose_IAM_SF"
  -cif sucrose.cif
  -hkl sucrose.hkl
  -xyz sucrose.xyz -IAM
  -no-date)

add_nosphera2_test(sucrose_twin "sucrose_fchk_SF"
  -cif sucrose.cif
  -hkl olex2/Wfn_job/sucrose.hkl
  -wfn olex2/Wfn_job/sucrose.wfx
  -acc 0
  -twin 1 0 0 0 -1 0 0 1 -2
  -no-date)

add_nosphera2_test(sucrose_ptb "sucrose_IAM_SF"
  -cif sucrose.cif
  -dmin 0.8
  -wfn wfn.xtb
  -mult 0
  -charge 0
  -acc 0
  -ECP 3
  -no-date)

add_nosphera2_test(disorder_THPP "disorder"
  -cif thpp.cif
  -hkl thpp.hkl
  -mtc olex2/Wfn_job/Part_1/thpp.wfx 0,1
  olex2/Wfn_job/Part_2/thpp.wfx 0,2
  -mtc_mult 1 1
  -mtc_charge 0 0
  -mtc_ECP 0 0
  -acc 0
  -no-date)

add_nosphera2_test(grown_water "grown"
  -cif water.cif
  -hkl water.hkl
  -wfn water.wfx
  -acc 0
  -no-date)

add_nosphera2_test(fourier_transform_full "SALTED"
  -test_analytical full -no-date)

add_nosphera2_test(fourier_transform "SALTED"
  -test_analytical -no-date)

add_nosphera2_test(fractal "sucrose_fchk_SF"
  -fractal sucrose_diff.cube
  -no_date)

add_nosphera2_test(properties "sucrose_fchk_SF"
  -wfn olex2/Wfn_job/sucrose.wfx
  -cif sucrose.cif -lap -eli
  -resolution 0.5 -test
  -no-date)

add_nosphera2_test(rubredoxin_cmtc "rubredoxin_cmtc"
  -hkl 1yk4_h.hkl -acc 0
  -cmtc residues/1.gbw residues/1.cif 0
  residues/2.gbw residues/2.cif 0,1
  residues/3.gbw residues/3.cif 0,2
  residues/4.gbw residues/4.cif 0
  -mtc_mult 1 1 1 1
  -mtc_charge 0 0 0 0
  -mtc_ECP 0 0 0 0
  -no-date)

add_nosphera2_test(rubredoxin_cmtc_full "rubredoxin_cmtc"
  -hkl 1yk4_h_full.hkl -acc 0
  -cmtc residues/1.gbw residues/1.cif 0
  residues/2.gbw residues/2.cif 0,1
  residues/3.gbw residues/3.cif 0,2
  residues/4.gbw residues/4.cif 0
  -mtc_mult 1 1 1 1
  -mtc_charge 0 0 0 0
  -mtc_ECP 0 0 0 0
  -cpus 24
  -no-date)

add_nosphera2_test(ri_fit "epoxide_gbw"
  -wfn epoxide.gbw
  -cif epoxide.cif
  -dmin 0.4
  -ri_fit
  -no-date)

add_nosphera2_test(Hybrid_mode "Hybrid"
  -cif ZP2.cif
  -dmin 0.9
  -acc 0
  -mtc ZP2_part1.gbw 0,1 ZP2_part2.gbw 0,2
  -mtc_mult 1 1
  -mtc_charge 0 0
  -mtc_ECP 0 0
  -no-date)

add_nosphera2_test(wfn_reading "wfn_reading"
  -hkl test.hkl -acc 0
  -cif test.cif -wfn test.wfn
  -no-date)

add_nosphera2_test(fchk_conversion "NiP3_fchk"
  -b def2-TZVP -d ./
  -wfn in.ffn -no-date)