idf_component_register(
  SRCS
    "main.c"
  INCLUDE_DIRS
    "../components/picoruby-esp32/picoruby/mrbgems/picoruby-mrubyc/lib/mrubyc/src"
    "../components/picoruby-esp32/picoruby/mrbgems/picoruby-mrubyc/lib/mrubyc/hal/esp32"
  REQUIRES
    picoruby-esp32
)

# add_prebuilt_library(
#   libmruby "../components/picoruby-esp32/picoruby/build/esp32/lib/libmruby.a"
#   REQUIRES picoruby-esp32
# )
# target_link_libraries(${COMPONENT_LIB} PRIVATE libmruby)