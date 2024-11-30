MRuby::CrossBuild.new('esp32') do |conf|
  toolchain :gcc

  conf.cc do |cc|
    # cc.include_paths << ENV["COMPONENT_INCLUDES"].split(';')

    cc.flags << '-Wno-maybe-uninitialized'
    # cc.flags << '-mlongcalls'
    cc.flags << '-std=gnu17'
    cc.flags = cc.flags.flatten.collect { |x| x.gsub('-MP', '') }

    cc.defines << "MRBC_TICK_UNIT=1"
    cc.defines << "MRBC_TIMESLICE_TICK_COUNT=10"
    cc.defines << "MRBC_USE_HAL_POSIX"

    cc.defines << 'MRB_HEAP_PAGE_SIZE=64'
    cc.defines << 'MRB_USE_IV_SEGLIST'
    cc.defines << 'KHASH_DEFAULT_SIZE=8'
    cc.defines << 'MRB_STR_BUF_MIN_SIZE=20'
    cc.defines << 'MRB_GC_STRESS'
    cc.defines << 'MRB_USE_METHOD_T_STRUCT'
    cc.defines << 'MRB_NO_BOXING'
    cc.defines << 'ESP_PLATFORM'
  end

  conf.cxx do |cxx|
    cxx.include_paths = conf.cc.include_paths.dup

    cxx.flags = cxx.flags.flatten.collect { |x| x.gsub('-MP', '') }

    cxx.defines = conf.cc.defines.dup
  end

  conf.gembox 'baremetal'
  conf.gem core: 'picoruby-mrubyc'
  conf.picoruby

  # conf.bins = []
  # conf.build_mrbtest_lib_only
  # conf.disable_cxx_exception

  # conf.gem :core => "mruby-print"
  # conf.gem :core => "mruby-compiler"
  # conf.gem :github => "mruby-esp32/mruby-io"
  # conf.gem :github => "mruby-esp32/mruby-fileio"
  # conf.gem :github => "mruby-esp32/mruby-socket"
  
  # conf.gem :github => "mruby-esp32/mruby-esp32-system"
  # conf.gem :github => "mruby-esp32/mruby-esp32-wifi"
  # conf.gem :github => "mruby-esp32/mruby-esp32-mqtt"
  
  # conf.gem :github => "mruby-esp32/mruby-esp32-gpio"
  # conf.gem :github => "mruby-esp32/mruby-esp32-adc"
  # conf.gem :github => "mruby-esp32/mruby-esp32-ledc"
  # conf.gem :github => "mruby-esp32/mruby-esp32-spi"
end