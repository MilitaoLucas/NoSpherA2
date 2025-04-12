    # enable_language('Fortran')
    if 'MSVC_VERSION'
      #  string(REPLACE "/STACK:10000000" "/STACK:900000000000000000"
      #    CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}")
      # string(['REGEX', 'REPLACE', '(.*)/STACK:(.*) (.*)', '\\1/STACK:900000000000000000 \\3', 'CMAKE_EXE_LINKER_FLAGS', '${CMAKE_EXE_LINKER_FLAGS}'])
    endif
    subdir('LIN')
    subdir('EIG')
    # macro(['add_lapack_test', 'output', 'input', 'target'])
    test_input = '${LAPACK_SOURCE_DIR}/TESTING/${input}'
    test_output = '${LAPACK_BINARY_DIR}/TESTING/${output}'
    # string(['REPLACE', '.', '_', 'input_name', input])
    testname = '${target}_${input_name}'
    if 'EXISTS', '${TEST_INPUT}'
      test('NAME', 'LAPACK-${testName}', 'COMMAND', '${CMAKE_COMMAND}', '-DTEST=$<TARGET_FILE:${target}>', '-DINPUT=${TEST_INPUT}', '-DOUTPUT=${TEST_OUTPUT}', '-DINTDIR=${CMAKE_CFG_INTDIR}', '-P', '${LAPACK_SOURCE_DIR}/TESTING/runtest.cmake')
    endif
    # endmacro()
    if 'BUILD_SINGLE'
      # add_lapack_test(['stest.out', 'stest.in', 'xlintsts'])
      #
      # ======== SINGLE RFP LIN TESTS ========================
      # add_lapack_test(['stest_rfp.out', 'stest_rfp.in', 'xlintstrfs'])
      #
      #
      # ======== SINGLE EIG TESTS ===========================
      #
      # add_lapack_test(['snep.out', 'nep.in', 'xeigtsts'])
      # add_lapack_test(['ssep.out', 'sep.in', 'xeigtsts'])
      # add_lapack_test(['sse2.out', 'se2.in', 'xeigtsts'])
      # add_lapack_test(['ssvd.out', 'svd.in', 'xeigtsts'])
      # add_lapack_test(['sec.out', 'sec.in', 'xeigtsts'])
      # add_lapack_test(['sed.out', 'sed.in', 'xeigtsts'])
      # add_lapack_test(['sgg.out', 'sgg.in', 'xeigtsts'])
      # add_lapack_test(['sgd.out', 'sgd.in', 'xeigtsts'])
      # add_lapack_test(['ssb.out', 'ssb.in', 'xeigtsts'])
      # add_lapack_test(['ssg.out', 'ssg.in', 'xeigtsts'])
      # add_lapack_test(['sbal.out', 'sbal.in', 'xeigtsts'])
      # add_lapack_test(['sbak.out', 'sbak.in', 'xeigtsts'])
      # add_lapack_test(['sgbal.out', 'sgbal.in', 'xeigtsts'])
      # add_lapack_test(['sgbak.out', 'sgbak.in', 'xeigtsts'])
      # add_lapack_test(['sbb.out', 'sbb.in', 'xeigtsts'])
      # add_lapack_test(['sglm.out', 'glm.in', 'xeigtsts'])
      # add_lapack_test(['sgqr.out', 'gqr.in', 'xeigtsts'])
      # add_lapack_test(['sgsv.out', 'gsv.in', 'xeigtsts'])
      # add_lapack_test(['scsd.out', 'csd.in', 'xeigtsts'])
      # add_lapack_test(['slse.out', 'lse.in', 'xeigtsts'])
      #
      # ======== SINGLE DMD EIG TESTS ===========================
      # add_lapack_test(['sdmd.out', 'sdmd.in', 'xdmdeigtsts'])
    endif
    if 'BUILD_DOUBLE'
      #
      # ======== DOUBLE LIN TESTS ===========================
      # add_lapack_test(['dtest.out', 'dtest.in', 'xlintstd'])
      #
      # ======== DOUBLE RFP LIN TESTS ========================
      # add_lapack_test(['dtest_rfp.out', 'dtest_rfp.in', 'xlintstrfd'])
      #
      # ======== DOUBLE EIG TESTS ===========================
      # add_lapack_test(['dnep.out', 'nep.in', 'xeigtstd'])
      # add_lapack_test(['dsep.out', 'sep.in', 'xeigtstd'])
      # add_lapack_test(['dse2.out', 'se2.in', 'xeigtstd'])
      # add_lapack_test(['dsvd.out', 'svd.in', 'xeigtstd'])
      # add_lapack_test(['dec.out', 'dec.in', 'xeigtstd'])
      # add_lapack_test(['ded.out', 'ded.in', 'xeigtstd'])
      # add_lapack_test(['dgg.out', 'dgg.in', 'xeigtstd'])
      # add_lapack_test(['dgd.out', 'dgd.in', 'xeigtstd'])
      # add_lapack_test(['dsb.out', 'dsb.in', 'xeigtstd'])
      # add_lapack_test(['dsg.out', 'dsg.in', 'xeigtstd'])
      # add_lapack_test(['dbal.out', 'dbal.in', 'xeigtstd'])
      # add_lapack_test(['dbak.out', 'dbak.in', 'xeigtstd'])
      # add_lapack_test(['dgbal.out', 'dgbal.in', 'xeigtstd'])
      # add_lapack_test(['dgbak.out', 'dgbak.in', 'xeigtstd'])
      # add_lapack_test(['dbb.out', 'dbb.in', 'xeigtstd'])
      # add_lapack_test(['dglm.out', 'glm.in', 'xeigtstd'])
      # add_lapack_test(['dgqr.out', 'gqr.in', 'xeigtstd'])
      # add_lapack_test(['dgsv.out', 'gsv.in', 'xeigtstd'])
      # add_lapack_test(['dcsd.out', 'csd.in', 'xeigtstd'])
      # add_lapack_test(['dlse.out', 'lse.in', 'xeigtstd'])
      #
      # ======== DOUBLE DMD EIG TESTS ===========================
      # add_lapack_test(['ddmd.out', 'ddmd.in', 'xdmdeigtstd'])
    endif
    if 'BUILD_COMPLEX'
      # add_lapack_test(['ctest.out', 'ctest.in', 'xlintstc'])
      #
      # ======== COMPLEX RFP LIN TESTS ========================
      # add_lapack_test(['ctest_rfp.out', 'ctest_rfp.in', 'xlintstrfc'])
      #
      # ======== COMPLEX EIG TESTS ===========================
      # add_lapack_test(['cnep.out', 'nep.in', 'xeigtstc'])
      # add_lapack_test(['csep.out', 'sep.in', 'xeigtstc'])
      # add_lapack_test(['cse2.out', 'se2.in', 'xeigtstc'])
      # add_lapack_test(['csvd.out', 'svd.in', 'xeigtstc'])
      # add_lapack_test(['cec.out', 'cec.in', 'xeigtstc'])
      # add_lapack_test(['ced.out', 'ced.in', 'xeigtstc'])
      # add_lapack_test(['cgg.out', 'cgg.in', 'xeigtstc'])
      # add_lapack_test(['cgd.out', 'cgd.in', 'xeigtstc'])
      # add_lapack_test(['csb.out', 'csb.in', 'xeigtstc'])
      # add_lapack_test(['csg.out', 'csg.in', 'xeigtstc'])
      # add_lapack_test(['cbal.out', 'cbal.in', 'xeigtstc'])
      # add_lapack_test(['cbak.out', 'cbak.in', 'xeigtstc'])
      # add_lapack_test(['cgbal.out', 'cgbal.in', 'xeigtstc'])
      # add_lapack_test(['cgbak.out', 'cgbak.in', 'xeigtstc'])
      # add_lapack_test(['cbb.out', 'cbb.in', 'xeigtstc'])
      # add_lapack_test(['cglm.out', 'glm.in', 'xeigtstc'])
      # add_lapack_test(['cgqr.out', 'gqr.in', 'xeigtstc'])
      # add_lapack_test(['cgsv.out', 'gsv.in', 'xeigtstc'])
      # add_lapack_test(['ccsd.out', 'csd.in', 'xeigtstc'])
      # add_lapack_test(['clse.out', 'lse.in', 'xeigtstc'])
      #
      # ======== COMPLEX DMD EIG TESTS ===========================
      # add_lapack_test(['cdmd.out', 'cdmd.in', 'xdmdeigtstc'])
    endif
    if 'BUILD_COMPLEX16'
      #
      # ======== COMPLEX16 LIN TESTS ========================
      # add_lapack_test(['ztest.out', 'ztest.in', 'xlintstz'])
      #
      # ======== COMPLEX16 RFP LIN TESTS ========================
      # add_lapack_test(['ztest_rfp.out', 'ztest_rfp.in', 'xlintstrfz'])
      #
      # ======== COMPLEX16 EIG TESTS ===========================
      # add_lapack_test(['znep.out', 'nep.in', 'xeigtstz'])
      # add_lapack_test(['zsep.out', 'sep.in', 'xeigtstz'])
      # add_lapack_test(['zse2.out', 'se2.in', 'xeigtstz'])
      # add_lapack_test(['zsvd.out', 'svd.in', 'xeigtstz'])
      # add_lapack_test(['zec.out', 'zec.in', 'xeigtstz'])
      # add_lapack_test(['zed.out', 'zed.in', 'xeigtstz'])
      # add_lapack_test(['zgg.out', 'zgg.in', 'xeigtstz'])
      # add_lapack_test(['zgd.out', 'zgd.in', 'xeigtstz'])
      # add_lapack_test(['zsb.out', 'zsb.in', 'xeigtstz'])
      # add_lapack_test(['zsg.out', 'zsg.in', 'xeigtstz'])
      # add_lapack_test(['zbal.out', 'zbal.in', 'xeigtstz'])
      # add_lapack_test(['zbak.out', 'zbak.in', 'xeigtstz'])
      # add_lapack_test(['zgbal.out', 'zgbal.in', 'xeigtstz'])
      # add_lapack_test(['zgbak.out', 'zgbak.in', 'xeigtstz'])
      # add_lapack_test(['zbb.out', 'zbb.in', 'xeigtstz'])
      # add_lapack_test(['zglm.out', 'glm.in', 'xeigtstz'])
      # add_lapack_test(['zgqr.out', 'gqr.in', 'xeigtstz'])
      # add_lapack_test(['zgsv.out', 'gsv.in', 'xeigtstz'])
      # add_lapack_test(['zcsd.out', 'csd.in', 'xeigtstz'])
      # add_lapack_test(['zlse.out', 'lse.in', 'xeigtstz'])
      #
      # ======== COMPLEX16 DMD EIG TESTS ===========================
      # add_lapack_test(['zdmd.out', 'zdmd.in', 'xdmdeigtstz'])
    endif
    if 'BUILD_SINGLE', 'AND', 'BUILD_DOUBLE'
      #
      # ======== SINGLE-DOUBLE PROTO LIN TESTS ==============
      # add_lapack_test(['dstest.out', 'dstest.in', 'xlintstds'])
    endif
    if 'BUILD_COMPLEX', 'AND', 'BUILD_COMPLEX16'
      #
      # ======== COMPLEX-COMPLEX16 LIN TESTS ========================
      # add_lapack_test(['zctest.out', 'zctest.in', 'xlintstzc'])
    endif
    # ==============================================================================
    # Only run this test if python 2.7 or greater is found
    if 'PYTHONINTERP_FOUND'
      # message(['STATUS', 'Running Summary'])
      # file(['COPY', lapack_source_dir, '/lapack_testing.py', 'DESTINATION', lapack_binary_dir])
      test('NAME', 'LAPACK_Test_Summary', 'WORKING_DIRECTORY', lapack_binary_dir, 'COMMAND', python_executable, 'lapack_testing.py')
    endif
    if 'WIN32'
      # file(['WRITE', cmake_current_binary_dir, '/test_helper.ps1', 'if (Test-Path $args[2]) { Remove-Item -Force $args[2] } \n', '$ErrorActionPreference = \"Stop\"\n', 'Get-Content $args[1] | & \"$($args[0]).exe\" | Out-File $args[2]\n', 'If ((Get-Content $args[2] | %{$_ -match \"FATAL\"}) -contains $true) {\n', 'echo Error\n', 'exit 1\n', '} else {\n', 'exit 0\n', '}\n'])
      helper_prefix = ['powershell', '-ExecutionPolicy', 'Bypass', '${CMAKE_CURRENT_BINARY_DIR}/test_helper.ps1']
    else
      # $1 exec, $2 input, $3 output_result
      # file(['WRITE', cmake_current_binary_dir, '/test_helper.sh', 'rm -f $3\n', '$1 < $2\n', 'grep -q FATAL $3\n', 'if [ $? -eq 0 ]; then\n', 'echo Error\n', 'exit 1\n', 'else\n', 'exit 0\n', 'fi\n'])
      helper_prefix = ['sh', '${CMAKE_CURRENT_BINARY_DIR}/test_helper.sh']
    endif
    test('NAME', 'REAL_LAPACK_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN/xlintsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/stest.in', '${CMAKE_CURRENT_BINARY_DIR}/stest.out')
    test('NAME', 'COMPLEX_LAPACK_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN/xlintstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/ctest.in', '${CMAKE_CURRENT_BINARY_DIR}/ctest.out')
    test('NAME', 'DOUBLE_PRECISION_LAPACK_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN//xlintstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dtest.in', '${CMAKE_CURRENT_BINARY_DIR}/dtest.out')
    test('NAME', 'COMPLEX16_LAPACK_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN//xlintstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/ztest.in', '${CMAKE_CURRENT_BINARY_DIR}/ztest.out')
    test('NAME', 'SINGLE-DOUBLE_PRECISION_LAPACK_prototype_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN/xlintstds', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dstest.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dstest.out')
    # ======== COMPLEX-COMPLEX16 LIN TESTS ========================
    test('NAME', 'Testing_COMPLEX-COMPLEX16_LAPACK_prototype_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN/xlintstzc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zctest.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zctest.out')
    # ======== SINGLE RFP LIN TESTS ========================
    test('NAME', 'Testing_REAL_LAPACK_RFP_prototype_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN/xlintstrfs', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/stest_rfp.in', '${CMAKE_CURRENT_BINARY_DIR}/stest_rfp.out')
    # ======== COMPLEX16 RFP LIN TESTS ========================
    test('NAME', 'Testing_DOUBLE_PRECISION_LAPACK_RFP_prototype_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN/xlintstrfd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dtest_rfp.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dtest_rfp.out')
    # ======== COMPLEX16 RFP LIN TESTS ========================
    test('NAME', 'Testing_COMPLEX_LAPACK_RFP_prototype_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN/xlintstrfc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/ctest_rfp.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ctest_rfp.out')
    # ======== COMPLEX16 RFP LIN TESTS ========================
    test('NAME', 'Testing_COMPLEX16_LAPACK_RFP_prototype_linear_equation_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/LIN/xlintstrfz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/ztest_rfp.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ztest_rfp.out')
    #
    #
    # ======== SINGLE EIG TESTS ===========================
    #
    test('NAME', 'SNEP:_Testing_Nonsymmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/nep.in', ' ${CMAKE_CURRENT_BINARY_DIR}/snep.out')
    test('NAME', 'SSEP:_Testing_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sep.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ssep.out')
    test('NAME', 'SSE2:_Testing_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/se2.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sse2.out')
    test('NAME', 'SSVD:_Testing_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/svd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ssvd.out')
    test('NAME', 'SSEC:_Testing_REAL_Eigen_Condition_Routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sec.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sec.out')
    test('NAME', 'SSEV:_Testing_REAL_Nonsymmetric_Eigenvalue_Driver', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sed.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sed.out')
    test('NAME', 'SGG:_Testing_REAL_Nonsymmetric_Generalized_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sgg.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sgg.out')
    test('NAME', 'SGD:_Testing_REAL_Nonsymmetric_Generalized_Eigenvalue_Problem_driver_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sgd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sgd.out')
    test('NAME', 'SSB:_Testing_REAL_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/ssb.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ssb.out')
    test('NAME', 'SSG:_Testing_REAL_Symmetric_Generalized_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/ssg.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ssg.out')
    test('NAME', 'SGEBAL:_Testing_the_balancing_of_a_REAL_general_matrix', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sbal.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sbal.out')
    test('NAME', 'SGEBAK:_Testing_the_back_transformation_of_a_REAL_balanced_matrix', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sbak.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sbak.out')
    test('NAME', 'SGGBAL:_Testing_the_balancing_of_a_pair_of_REAL_general_matrices', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sgbal.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sgbal.out')
    test('NAME', 'SGGBAK:_Testing_the_back_transformation_of_a_pair_of_REAL_balanced_matrices', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sgbak.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sgbak.out')
    test('NAME', 'SBB:_Testing_banded_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sbb.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sbb.out')
    test('NAME', 'SGLM:_Testing_Generalized_Linear_Regression_Model_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/glm.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sglm.out')
    test('NAME', 'SGQR:_Testing_Generalized_QR_and_RQ_factorization_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/gqr.in', ' ${CMAKE_CURRENT_BINARY_DIR}/sgqr.out')
    test('NAME', 'SGSV:_Testing_Generalized_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/gsv.in', '${CMAKE_CURRENT_BINARY_DIR}/sgsv.out')
    test('NAME', 'SCSD:_Testing_CS_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/csd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/scsd.out')
    test('NAME', 'SLSE:_Testing_Constrained_Linear_Least_Squares_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtsts', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/lse.in', ' ${CMAKE_CURRENT_BINARY_DIR}/slse.out')
    # ======== COMPLEX EIG TESTS ===========================
    test('NAME', 'CNEP:_Testing_Nonsymmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/nep.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cnep.out')
    test('NAME', 'CSEP:_Testing_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sep.in', ' ${CMAKE_CURRENT_BINARY_DIR}/csep.out')
    test('NAME', 'CSE2:_Testing_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/se2.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cse2.out')
    test('NAME', 'CSVD:_Testing_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/svd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/csvd.out')
    test('NAME', 'CEC:_Testing_COMPLEX_Eigen_Condition_Routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/cec.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cec.out')
    test('NAME', 'CES:_Testing_COMPLEX_Nonsymmetric_Schur_Form_Driver', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/ced.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ced.out')
    test('NAME', 'CGG:_Testing_COMPLEX_Nonsymmetric_Generalized_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/cgg.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cgg.out')
    test('NAME', 'CGD:_Testing_COMPLEX_Nonsymmetric_Generalized_Eigenvalue_Problem_driver_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/cgd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cgd.out')
    test('NAME', 'CHB:_Testing_Hermitian_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/csb.in', ' ${CMAKE_CURRENT_BINARY_DIR}/csb.out')
    test('NAME', 'CSG:_Testing_Symmetric_Generalized_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/csg.in', ' ${CMAKE_CURRENT_BINARY_DIR}/csg.out')
    test('NAME', 'CGEBAL:_Testing_the_balancing_of_a_COMPLEX_general_matrix', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/cbal.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cbal.out')
    test('NAME', 'CGEBAK:_Testing_the_back_transformation_of_a_COMPLEX_balanced_matrix', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/cbak.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cbak.out')
    test('NAME', 'CGGBAL:_Testing_the_balancing_of_a_pair_of_COMPLEX_general_matrices', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/cgbal.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cgbal.out')
    test('NAME', 'CGGBAK:_Testing_the_back_transformation_of_a_pair_of_COMPLEX_balanced_matrices', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/cgbak.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cgbak.out')
    test('NAME', 'CBB:_Testing_banded_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/cbb.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cbb.out')
    test('NAME', 'CGLM:_Testing_Generalized_Linear_Regression_Model_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/glm.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cglm.out')
    test('NAME', 'CGQR:_Testing_Generalized_QR_and_RQ_factorization_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/gqr.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cgqr.out')
    test('NAME', 'CGSV:_Testing_Generalized_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/gsv.in', ' ${CMAKE_CURRENT_BINARY_DIR}/cgsv.out')
    test('NAME', 'CCSD:_Testing_CS_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/csd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ccsd.out')
    test('NAME', 'CLSE:_Testing_Constrained_Linear_Least_Squares_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstc', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/lse.in', ' ${CMAKE_CURRENT_BINARY_DIR}/clse.out')
    # ======== DOUBLE EIG TESTS ===========================
    test('NAME', 'DNEP:_Testing_Nonsymmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/nep.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dnep.out')
    test('NAME', 'DSEP:_Testing_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sep.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dsep.out')
    test('NAME', 'DSE2:_Testing_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/se2.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dse2.out')
    test('NAME', 'DSVD:_Testing_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/svd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dsvd.out')
    test('NAME', 'DEC:_Testing_DOUBLE_PRECISION_Eigen_Condition_Routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dec.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dec.out')
    test('NAME', 'DEV:_Testing_DOUBLE_PRECISION_Nonsymmetric_Eigenvalue_Driver', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/ded.in', ' ${CMAKE_CURRENT_BINARY_DIR}/ded.out')
    test('NAME', 'DGG:_Testing_DOUBLE_PRECISION_Nonsymmetric_Generalized_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dgg.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dgg.out')
    test('NAME', 'DGD:_Testing_DOUBLE_PRECISION_Nonsymmetric_Generalized_Eigenvalue_Problem_driver_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dgd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dgd.out')
    test('NAME', 'DSB:_Testing_DOUBLE_PRECISION_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dsb.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dsb.out')
    test('NAME', 'DSG:_Testing_DOUBLE_PRECISION_Symmetric_Generalized_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dsg.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dsg.out')
    test('NAME', 'DGEBAL:_Testing_the_balancing_of_a_DOUBLE_PRECISION_general_matrix', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dbal.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dbal.out')
    test('NAME', 'DGEBAK:_Testing_the_back_transformation_of_a_DOUBLE_PRECISION_balanced_matrix', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dbak.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dbak.out')
    test('NAME', 'DGGBAL:_Testing_the_balancing_of_a_pair_of_DOUBLE_PRECISION_general_matrices', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dgbal.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dgbal.out')
    test('NAME', 'DGGBAK:_Testing_the_back_transformation_of_a_pair_of_DOUBLE_PRECISION_balanced_matrices', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dgbak.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dgbak.out')
    test('NAME', 'DBB:_Testing_banded_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/dbb.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dbb.out')
    test('NAME', 'DGLM:_Testing_Generalized_Linear_Regression_Model_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/glm.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dglm.out')
    test('NAME', 'DGQR:_Testing_Generalized_QR_and_RQ_factorization_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/gqr.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dgqr.out')
    test('NAME', 'DGSV:_Testing_Generalized_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/gsv.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dgsv.out')
    test('NAME', 'DCSD:_Testing_CS_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/csd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dcsd.out')
    test('NAME', 'DLSE:_Testing_Constrained_Linear_Least_Squares_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstd', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/lse.in', ' ${CMAKE_CURRENT_BINARY_DIR}/dlse.out')
    # ======== COMPLEX16 EIG TESTS ===========================
    test('NAME', 'ZNEP:_Testing_Nonsymmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/nep.in', ' ${CMAKE_CURRENT_BINARY_DIR}/znep.out')
    test('NAME', 'ZSEP:_Testing_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/sep.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zsep.out')
    test('NAME', 'ZSE2:_Testing_Symmetric_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/se2.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zse2.out')
    test('NAME', 'ZSVD:_Testing_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/svd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zsvd.out')
    test('NAME', 'ZEC:_Testing_COMPLEX16_Eigen_Condition_Routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zec.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zec.out')
    test('NAME', 'ZES:_Testing_COMPLEX16_Nonsymmetric_Schur_Form_Driver', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zed.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zed.out')
    test('NAME', 'ZGG:_Testing_COMPLEX16_Nonsymmetric_Generalized_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zgg.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zgg.out')
    test('NAME', 'ZGD:_Testing_COMPLEX16_Nonsymmetric_Generalized_Eigenvalue_Problem_driver_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zgd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zgd.out')
    test('NAME', 'ZHB:_Testing_Hermitian_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zsb.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zsb.out')
    test('NAME', 'ZSG:_Testing_Symmetric_Generalized_Eigenvalue_Problem_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zsg.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zsg.out')
    test('NAME', 'ZGEBAL:_Testing_the_balancing_of_a_COMPLEX16_general_matrix', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zbal.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zbal.out')
    test('NAME', 'ZGEBAK:_Testing_the_back_transformation_of_a_COMPLEX16_balanced_matrix', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zbak.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zbak.out')
    test('NAME', 'ZGGBAL:_Testing_the_balancing_of_a_pair_of_COMPLEX_general_matrices', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zgbal.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zgbal.out')
    test('NAME', 'ZGGBAK:_Testing_the_back_transformation_of_a_pair_of_COMPLEX16_balanced_matrices', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zgbak.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zgbak.out')
    test('NAME', 'ZBB:_Testing_banded_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/zbb.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zbb.out')
    test('NAME', 'ZGLM:_Testing_Generalized_Linear_Regression_Model_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/glm.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zglm.out')
    test('NAME', 'ZGQR:_Testing_Generalized_QR_and_RQ_factorization_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/gqr.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zgqr.out')
    test('NAME', 'ZGSV:_Testing_Generalized_Singular_Value_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/gsv.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zgsv.out')
    test('NAME', 'ZCSD:_Testing_CS_Decomposition_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/csd.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zcsd.out')
    test('NAME', 'Constrained_Linear_Least_Squares_routines', 'COMMAND', helper_prefix, '${CMAKE_CURRENT_BINARY_DIR}/EIG/xeigtstz', '${PROJECT_SOURCE_DIR}/lapack-netlib/TESTING/lse.in', ' ${CMAKE_CURRENT_BINARY_DIR}/zlse.out')
