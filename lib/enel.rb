require 'enel/version'

module Enel
  def define_call_command(proc)
    no_commands do
      define_method(:call_command) { |*args|proc.call(*args) }
    end
    private :call_command
    define_each_commands
  end

  private

  def define_each_commands
    instance_methods(false).each { |command|define_each_command(command) }
  end

  def define_each_command(command)
    no_commands do
      define_method(command) { |*args|call_command(command, *args) }
    end
  end
end
