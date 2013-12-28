class Image

  def initialize(m, n)
    @chars = Array.new(n) { Array.new(m) { ('O') } }
  end

  def m
    @chars[0].size
  end

  def n
    @chars.size
  end

  def contains?(coords)
    x, y = coords
    (x <= m && x > 0) && (y <= n && y > 0)
  end

  def pixel_colour(coords)
    @chars[coords[1] -1][coords[0] -1]
  end

  def colour_pixel(coords, colour)
    @chars[coords[1] - 1][coords[0] -1] = colour
  end

  def colour_fill(coords, colour)
    old_colour = pixel_colour(coords)
    colour_pixel(coords, colour)
    adjacent_pixels_same_colour(coords, old_colour).each do |adjacent|
      if pixel_colour(adjacent) != colour
        colour_fill(adjacent, colour)
      end
    end
  end

  def adjacent_pixels_same_colour(coords, colour)
    x, y = coords
    pixel_list = []
    pixel_list << [x-1, y] if self.contains?([x-1, y]) && pixel_colour([x-1, y]) == colour
    pixel_list << [x+1, y] if self.contains?([x+1, y]) && pixel_colour([x+1, y]) == colour
    pixel_list << [x, y-1] if self.contains?([x, y-1]) && pixel_colour([x, y-1]) == colour
    pixel_list << [x, y+1] if self.contains?([x, y+1]) && pixel_colour([x, y+1]) == colour
    pixel_list
  end

  def transpose
    @chars = @chars.transpose
  end

  def to_s
    @chars.map { |row| "#{row.join('')}\n" }.join('')
  end

end
