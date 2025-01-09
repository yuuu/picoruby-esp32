idf_component_register(
  SRCS main.c
  INCLUDE_DIRS
    ${CMAKE_SOURCE_DIR}/components/picoruby-esp32
  REQUIRES
    picoruby-esp32
    nvs_flash
)
