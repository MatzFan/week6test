require_relative 'image'

class Editor

  COMMANDS = {:HELP => 'Shows this command list',
              :X => 'Exit',
              :I => 'Create new image M x N',
              :C => 'Clears the table, setting all pixels to white (O)',
              :S => 'Shows the current Image',
              :L => 'Colours a single pixel (X,Y) with colour C',
              :H => 'Draws a horizonal segment of colour C in row Y between'+
                    ' columns X1 and X2 inclusive',
              :V => 'Draws a vertical segment of colour C in column X between'+
                    ' rows Y1 and Y2 inclusive',
              :F => 'Fills contiguous region with colour C starting at pixel'+
                    ' X,Y'}

  VALID_COLOURS = ('A'..'Z').to_a

  def initialize
    display_splash_message
    @image = nil
  end

  def display_splash_message
    puts "Welcome to the graphical editor.\nThe commands are:\n"
    help
    puts 'Please enter a command'
  end

  def do_command(input)
    return 'Please enter a valid command' if input.empty?
    command, params = parse(input)
    validate(command, params)
  end

  def parse(input)
    args = input.split(' ')
    args.each_with_index { |arg, i| args[i] = arg.to_i if arg =~ /^[0-9]+$/ }
    command = args[0]
    return args.length == 1 ? command : command, args[1..-1]
  end

  def validate(command, params)
    if COMMANDS.keys.include? command.to_sym
      self.send(command.downcase, params)
    else
      return "'#{command}' is not valid, try 'help'"
    end
  end

  def valid_coords?(coords)
    x = coords[0].to_i
    y = coords[1].to_i
    @image ? x <= @image.m && y <= @image.n : x <= 250 && y <= 250
  end

  def valid_colour?(colour)
    VALID_COLOURS.include? colour
  end

  def no_params_message(command)
    "'#{command.upcase}' does not take parameters."
  end

  def help
    COMMANDS.each_pair { |cmd,function| puts "#{cmd}: #{function}" }
  end

  def c(params)
    return no_params_message(__method__) unless params.empty?
    @image = Image.new(@image.m, @image.n)
  end

  def x(params)
    return no_params_message(__method__) unless params.empty?
    exit
  end

  def s(params)
    return no_params_message(__method__) unless params.empty?
    puts @image
  end

  def i(params)
    if valid_coords?(params)
      m, n = params[0].to_i, params[1].to_i
      @image = Image.new(m, n)
    end
  end

  def l(params)
    coords = params[0], params[1]
    colour = params[2]
    if valid_coords?(coords) && valid_colour?(colour)
      @image.colour_pixel(coords, colour)
    end
  end

  def v(params)
    puts @image
  end

  def h(params)
    puts @image
  end

  def f(params)
    puts @image
  end

end # of class
