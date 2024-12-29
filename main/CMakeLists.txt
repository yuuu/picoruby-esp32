idf_component_register(
  SRCS main.c
  INCLUDE_DIRS
    ${CMAKE_SOURCE_DIR}/components/picoruby-esp32/picoruby/mrbgems/picoruby-mrubyc/lib/mrubyc/src
    ${CMAKE_SOURCE_DIR}/components/picoruby-esp32/picoruby/mrbgems/picoruby-mrubyc/lib/mrubyc/hal/esp32
    ${CMAKE_SOURCE_DIR}/components/picoruby-esp32/picoruby/build/esp32/mrbgems
  REQUIRES
    picoruby-esp32
    nvs_flash
)

add_definitions(
  -DMRBC_USE_FLOAT=2
  -DNDEBUG
)

add_custom_target(
  mrbdir ALL
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/build/mrb
)
add_dependencies(${COMPONENT_LIB} mrbdir)

set(RUBY_FILES main_task)
set(PICORBC ${CMAKE_SOURCE_DIR}/components/picoruby-esp32/picoruby/bin/picorbc)

foreach(rb ${RUBY_FILES})
add_custom_target(${rb}
  COMMAND ${PICORBC} -B${rb} -o${CMAKE_SOURCE_DIR}/build/mrb/${rb}.c ${CMAKE_SOURCE_DIR}/mrblib/${rb}.rb
  DEPENDS mrbdir
)
endforeach(rb)

add_custom_target(generate_files ALL DEPENDS mrbdir ${RUBY_FILES})
add_dependencies(${COMPONENT_LIB} generate_files)
