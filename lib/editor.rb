require_relative 'image'

class Editor

  VALID_COLOURS = ('A'..'Z').to_a

  X_MAX, Y_MAX = 250, 250

  CMD_TEXT = {
    :HELP => 'Shows this command list',
    :I => "Creates new image M x N pixels up to #{X_MAX} x #{Y_MAX}",
    :C => 'Clears the table, setting all pixels to white (O)',
    :L => 'Colours a single pixel (X,Y) with colour C',
    :V => 'Draws a vertical segment of colour C in column X between'+
          ' rows Y1 and Y2 inclusive',
    :H => 'Draws a horizonal segment of colour C in row Y between'+
          ' columns X1 and X2 inclusive',
    :F => 'Fills contiguous region with colour C starting at pixel X,Y',
    :S => 'Shows the current image',
    :X => 'Exit'
  }

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

  def validate(cmd, params)
    return "'#{cmd}' invalid, try 'help'" if !CMD_TEXT.keys.include? cmd.to_sym
    begin
      self.send(cmd.downcase, params)
    rescue ArgumentError => e
      return e.message
    end
  end

  def valid_coords?(coords)
    return unless coords.length == 2 && coords.all? { |c| c.is_a? Integer }
    return unless coords[0] > 0 && coords[1] > 0
    @image ? coords[0] <= @image.m && coords[1] <= @image.n : true
  end

  def no_params(command)
    "'#{command.upcase}' does not take parameters."
  end

  def wrong_number_of_params(command, num)
    "#{command.upcase} takes #{num} parameters, try 'help'"
  end

  def no_image_yet
    "Create an image first with 'I'"
  end

  def help(params_ignored)
    CMD_TEXT.each_pair do |cmd, text|
      puts "#{cmd}: #{text}"
    end
  end

  def c(params)
    return no_params(__method__) unless params.empty?
    @image = Image.new(@image.m, @image.n) if @image
  end

  def s(params)
    return no_params(__method__) unless params.empty?
    puts @image
  end

  def x(params)
    return no_params(__method__) unless params.empty?
    exit
  end

  def i(params)
    return wrong_number_of_params(__method__, 2) if params.length != 2
    return 'Invalid coordinates' unless valid_coords?(params)
    m, n = params[0], params[1]
    return "Maximum size is #{X_MAX} x #{Y_MAX}" if (m > 250 || n > 250)
    @image = Image.new(m, n)
  end

  def check_colour(colour)
    raise ArgumentError, 'Invalid colour' unless VALID_COLOURS.include? colour
    colour
  end

  def check_coords(coords)
    raise ArgumentError, 'Invalid coordinates' unless valid_coords?(coords)
    coords
  end

  def l(params)
    return no_image_yet unless @image
    return wrong_number_of_params(__method__, 3) if params.length != 3
    colour = check_colour(params.pop)
    coords = check_coords(params)
    @image.colour_pixel(coords, colour)
  end

  def v(params)
    return no_image_yet unless @image
    return wrong_number_of_params(__method__, 4) if params.length != 4
    colour = check_colour(params.pop)
    x = params.shift
    y1, y2 = params
    check_coords([x, y1])
    check_coords([x, y2])
    (y1..y2).each { |y| @image.colour_pixel([x,y], colour) }
  end

  def h(params)
    return no_image_yet unless @image
    return wrong_number_of_params(__method__, 4) if params.length != 4
    params.unshift(params.delete_at(2)) # gets params in same order as 'v'
    @image.transpose
    begin
      v(params)
    ensure
      @image.transpose
    end
  end

  def f(params)
    return no_image_yet unless @image
    return wrong_number_of_params(__method__, 3) if params.length != 3
    colour = check_colour(params.pop)
    coords = check_coords(params)
    @image.colour_fill(coords, colour)
  end

end # of class
