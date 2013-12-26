require_relative 'image'

class Editor

  VALID_COLOURS = ('A'..'Z').to_a

  X_MAX, Y_MAX = 250, 250

  COMMANDS = {:HELP => 'Shows this command list',
              :X => 'Exit',
              :I => "Creates new image M x N pixels up to #{X_MAX} x #{Y_MAX}",
              :C => 'Clears the table, setting all pixels to white (O)',
              :S => 'Shows the current Image',
              :L => 'Colours a single pixel (X,Y) with colour C',
              :H => 'Draws a horizonal segment of colour C in row Y between'+
                    ' columns X1 and X2 inclusive',
              :V => 'Draws a vertical segment of colour C in column X between'+
                    ' rows Y1 and Y2 inclusive',
              :F => 'Fills contiguous region with colour C starting at pixel'+
                    ' X,Y'}

  def initialize
    display_splash_message
    @image = nil
  end

  def display_splash_message
    puts "Welcome to the graphical editor. The commands are:\n\n"
    help(nil)
    puts "\nPlease enter a command"
  end

  def do_command(input)
    return 'Please enter a valid command' if input.strip.empty?
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
    return unless coords.length == 2 && coords.all? { |c| c.is_a? Integer }
    return unless coords[0] > 0 && coords[1] > 0
    @image ? coords[0] <= @image.m && coords[1] <= @image.n : true
  end

  def valid_colour?(colour)
    VALID_COLOURS.include? colour
  end

  def no_params_message(command)
    "'#{command.upcase}' does not take parameters."
  end

  def wrong_number_of_params(command, num)
    "#{command.upcase} takes #{num} parameters, try 'help'"
  end

  def no_image_yet
    "Create an image first with 'I'"
  end

  def help(params_ignored)
    COMMANDS.each_pair { |cmd,function| puts "#{cmd}: #{function}" }
  end

  def c(params)
    return no_params_message(__method__) unless params.empty?
    @image = Image.new(@image.m, @image.n) if @image
  end

  def s(params)
    return no_params_message(__method__) unless params.empty?
    puts @image
  end

  def x(params)
    return no_params_message(__method__) unless params.empty?
    exit
  end

  def i(params)
    return wrong_number_of_params(__method__, 2) if params.length != 2
    return 'Invalid coordinates' unless valid_coords?(params)
    m, n = params[0], params[1]
    return "Maximum size is #{X_MAX} x #{Y_MAX}" if (m > 250 || n > 250)
    @image = Image.new(m, n)
  end

  def l(params)
    return no_image_yet unless @image
    return wrong_number_of_params(__method__, 3) if params.length != 3
    coords = params[0], params[1]
    colour = params[2]
    return 'Invalid coordinates' unless valid_coords?(coords)
    return 'Invalid colour' unless valid_colour?(colour)
    @image.colour_pixel(coords, colour)
  end

  def v(params)
    return no_image_yet unless @image

  end

  def h(params)
    return no_image_yet unless @image

  end

  def f(params)
    return no_image_yet unless @image

  end

end # of class
