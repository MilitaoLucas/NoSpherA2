if(LIBOMP_OMPT_SUPPORT)
  include_directories(${LIBOMP_INCLUDE_DIR})

  add_library(ompt-multiplex INTERFACE)
  target_include_directories(ompt-multiplex INTERFACE .)

  install(FILES ompt-multiplex.h DESTINATION "${LIBOMP_HEADERS_INSTALL_PATH}")

  add_subdirectory(tests)
endif()
