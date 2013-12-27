class Image

  def initialize(m, n)
    @chars = Array.new(n) { Array.new(m) { 'O' } }
  end

  def m
    @chars[0].size
  end

  def n
    @chars.size
  end

  def colour_pixel(coords, colour)
    y, x = coords
    @chars[x - 1][y -1] = colour
  end

  def colour_fill(coords, colour)
    y, x = coords
  end

  def transpose
    @chars = @chars.transpose
  end

  def to_s
    @chars.map { |row| "#{row.join('')}\n" }.join('').chomp
  end

end
