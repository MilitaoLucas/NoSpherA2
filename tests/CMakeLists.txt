include(CTest)

find_program(DIFF_COMMAND NAMES diff fc)
find_program(MV_COMMAND NAMES mv move)
find_program(MAKE NAMES make)

set(PROGRAM ${CMAKE_BINARY_DIR})
if(WIN32)
  set(DIFF_ARGS "/c")

else()
  set(DIFF_ARGS "-q -i -b")
  set(PROGRAM ${CMAKE_BINARY_DIR})
endif()

add_test(NAME "alanine_occ"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} alanine_occ)

add_test(NAME "Hybrid_mode"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} Hybrid_mode)

add_test(NAME "SALTED"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} SALTED)

add_test(NAME "disorder_THPP"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} disorder_THPP)

add_test(NAME "fourier_transform"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} fourier_transform)

add_test(NAME "fractal"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} fractal)

add_test(NAME "grown_water"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} grown_water)

add_test(NAME "malbac_SF_ECP"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} malbac_SF_ECP)

add_test(NAME "openBLAS"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} openBLAS)

add_test(NAME "properties"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} properties)

add_test(NAME "reading_SALTED"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} reading_SALTED)

add_test(NAME "ri_fit"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} ri_fit)

add_test(NAME "rubredoxin_cmtc"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} rubredoxin_cmtc)

add_test(NAME "sucrose_IAM"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} sucrose_IAM)

add_test(NAME "sucrose_ptb"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} sucrose_ptb)

add_test(NAME "sucrose_twin"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} sucrose_twin)

add_test(NAME "wfn_reading"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} wfn_reading)

add_test(NAME "sucrose_fchk_wf"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tests
    COMMAND ${MAKE} EXE_PATH=${PROGRAM} sucrose_fchk_SF)
