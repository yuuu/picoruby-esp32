require "shell"
require 'machine'

STDIN = IO
STDOUT = IO

# Setup flash disk
begin
  Machine.using_delay do
    STDIN.echo = false
    $shell = Shell.new(clean: true)

    puts "Starting shell...\n\n"
    
    $shell.show_logo
    $shell.start
  end
rescue => e
  puts "Not available"
  puts "#{e.message} (#{e.class})"
end
