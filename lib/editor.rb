#!/usr/bin/env ruby

class Editor

  COMMANDS = {X: 'Exit',
              I: 'Create new image M x N',
               }

  def initialize
    puts "Welcome to the graphical editor.\n"\
    "The commands are:\n"
    show_commands
    puts 'Please enter your command'
  end

  def show_commands
    COMMANDS.each_pair { |cmd,function| puts "#{cmd}: #{function}" }
  end

  def do_the(command)
    validate_command
    self.send(command.downcase)
  end

  def validate_command(command)

  end

  def s

  end

end # of class
