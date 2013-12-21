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
    return 'Please enter a valid command' if input.empty?
    command, params = parse(input)
    validate(command, params)
  end

  def parse(input)
    args = input.split(' ')
    return args[0], args[1..-1]
  end

  def validate(command, params)
    if COMMANDS.keys.include? command.to_sym
      self.send(command.downcase!, params)
    else
      return "'#{command}' is not valid, hit '?' for command list"
    end
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

p Editor::COMMANDS.keys

