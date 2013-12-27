class Image

  attr_reader :m, :n

  def initialize(m, n)
    @m = m
    @n = n
    @chars = Array.new(n) { Array.new(m) { 'O' } }
  end

  def colour_pixel(coords, colour)
    y, x = coords
    @chars[x - 1][y -1] = colour
  end

  def colour_fill(coords, colour)
    # x, y = coords
  end

  def to_s
    @chars.map { |row| "#{row.join('')}\n" }.join('').chomp
  end

end
