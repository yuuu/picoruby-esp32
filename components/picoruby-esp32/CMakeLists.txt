set(PICORUBY_DIR "${COMPONENT_DIR}/picoruby")
set(LIB_PICORUBY_FILE "${COMPONENT_DIR}/picoruby/build/esp32/lib/libmruby.a")
set(CONFIG ${COMPONENT_DIR}/esp32_build_config.rb)

idf_component_register(
  INCLUDE_DIRS picoruby/include
)

add_custom_command(
  OUTPUT ${LIB_PICORUBY_FILE}
  COMMAND ${CMAKE_COMMAND} -E env "MRUBY_CONFIG=${CONFIG}" rake
  WORKING_DIRECTORY ${PICORUBY_DIR}
  BYPRODUCTS ${COMPONENT_DIR}/esp32_build_config.rb.lock
  VERBATIM
)

add_prebuilt_library(
  libpicoruby ${LIB_PICORUBY_FILE}
)
target_link_libraries(${COMPONENT_LIB} INTERFACE libpicoruby)

add_custom_target(picoruby DEPENDS ${LIB_PICORUBY_FILE})
add_dependencies(${COMPONENT_LIB} picoruby)
