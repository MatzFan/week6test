class Editor

  COMMANDS = {X: 'Exit',
              I: 'Create new image M x N',
               }

  def initialize
    display_splash_message
  end

  def display_splash_message
    puts "Welcome to the graphical editor.\nThe commands are:\n"
    show_commands
    puts 'Please enter a command'
  end

  def show_commands
    COMMANDS.each_pair { |cmd,function| puts "#{cmd}: #{function}" }
  end

  def do_command(input)
    validate_the input
    self.send(input.downcase)
  end

  def validate_the(command)

  end

  def x
    exit
  end

end # of class
