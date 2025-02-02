require "shell"
require 'machine'

STDIN = IO
STDOUT = IO

# Setup flash disk
begin
  Machine.using_delay do
    STDIN.echo = false
    $shell = Shell.new(clean: true)

    puts "Initializing FLASH disk as the root volume... "
    $shell.setup_root_volume(:flash, label: 'storage')
    $shell.setup_system_files
    puts "Available"
  end
rescue => e
  puts "Not available"
  puts "#{e.message} (#{e.class})"
end

begin
  Machine.using_delay do
    if File.exist?("/home/app.mrb")
      puts "Loading app.mrb"
      load "/home/app.mrb"
    elsif File.exist?("/home/app.rb")
      puts "Loading app.rb"
      load "/home/app.rb"
    end

    puts "Starting shell...\n\n"
    
    $shell.show_logo
    $shell.start
  end
rescue => e
  puts "#{e.message} (#{e.class})"
end
