class Image

  attr_reader :m, :n

  def initialize(m, n)
    @m = m
    @n = n
    @chars = Array.new(m * n, 'O')
  end

  def colour_pixel(coords,colour)
    x, y = coords
    @chars[(y - 1) * @m + x - 1] = colour
  end

  def to_s
    string = ''
    (0..@n -1).inject(string) do |string, num|
      string << "#{@chars[num * @m..@m * (num + 1) -1].join('')}\n"
    end
    string.chomp
  end

end
