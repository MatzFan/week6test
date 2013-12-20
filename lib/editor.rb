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
    command, params = parse(input)
    self.send(command.downcase!, params) if validate(command, params)
  end

  def parse(input)
    args = input.split(' ')
    return args[0], args[1..-1]
  end

  def validate(command, params)
    true
  end

  def x(ignored)
    exit
  end

  def i(coords)
    m, n = coords
    m, n = m.to_i, n.to_i
    s = ''
    n.times { s << "#{'O' * m}\n" }
    s.chomp
  end

end # of class
