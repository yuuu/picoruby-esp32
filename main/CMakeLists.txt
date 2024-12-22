idf_component_register(
  SRCS main.c
  INCLUDE_DIRS
    ${CMAKE_SOURCE_DIR}/components/picoruby-esp32/picoruby/mrbgems/picoruby-mrubyc/lib/mrubyc/src
    ${CMAKE_SOURCE_DIR}/components/picoruby-esp32/picoruby/mrbgems/picoruby-mrubyc/lib/mrubyc/hal/esp32
  REQUIRES
    picoruby-esp32
    nvs_flash
)

add_custom_target(
  mrbdir ALL
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/build/mrb
)

set(RUBY_FILES main_task)

add_dependencies(${COMPONENT_LIB} mrbdir)
add_dependencies(${COMPONENT_LIB} ${RUBY_FILES})

set(PICORBC ${CMAKE_SOURCE_DIR}/components/picoruby-esp32/picoruby/bin/picorbc)

foreach(rb ${RUBY_FILES})
add_custom_target(${rb}
  COMMAND ${PICORBC} -B${rb} -o${CMAKE_SOURCE_DIR}/build/mrb/${rb}.c ${CMAKE_SOURCE_DIR}/mrblib/${rb}.rb
)
endforeach(rb)
