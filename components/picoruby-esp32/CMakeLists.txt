idf_component_register(
  SRCS
    picoruby/mrbgems/picoruby-machine/ports/esp32/machine.c
  INCLUDE_DIRS "."
  REQUIRES esp_driver_uart
)

set(PICORUBY_DIR ${COMPONENT_DIR}/picoruby)
set(LIBMRUBY_FILE ${PICORUBY_DIR}/build/esp32/lib/libmruby.a)

add_custom_command(
    OUTPUT ${LIBMRUBY_FILE}
    COMMAND ${CMAKE_COMMAND} -E echo "MRUBY_CONFIG=${IDF_TARGET_ARCH}-esp rake"
    COMMAND ${CMAKE_COMMAND} -E env MRUBY_CONFIG=${IDF_TARGET_ARCH}-esp rake
    WORKING_DIRECTORY ${PICORUBY_DIR}
    COMMENT "PicoRuby build"
    VERBATIM
)

add_prebuilt_library(
  libmruby ${LIBMRUBY_FILE}
  REQUIRES picoruby-esp32
)
target_link_libraries(${COMPONENT_LIB} PRIVATE libmruby)

add_custom_target(
  picoruby DEPENDS ${LIBMRUBY_FILE}
  DEPENDS ${LIBMRUBY_FILE}
)
add_dependencies(${COMPONENT_LIB} picoruby)
