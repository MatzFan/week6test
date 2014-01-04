class Image

  attr_accessor :chars

  def initialize(m, n)
    @chars = Array.new(n) { Array.new(m) { ('O') } }
  end

  def m
    @chars.first.size
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
    pixels_to_colour = [coords]
    while !pixels_to_colour.empty?
      pixels_to_colour.each { |coords| colour_pixel(coords, colour) }
      coloured_pixels = pixels_to_colour.dup
      coloured_pixels.each do |adjacent|
        next_pixel_set = adjacent_pixels_same_colour(adjacent, old_colour)
        pixels_to_colour += next_pixel_set if next_pixel_set
      end
      pixels_to_colour = pixels_to_colour.uniq
      pixels_to_colour.shift(coloured_pixels.count)
    end
  end

  # def colour_fill(coords, colour)
  #   old_colour = pixel_colour(coords)
  #   colour_pixel(coords, colour)
  #   adjacent_pixels_same_colour(coords, old_colour).each do |adjacent|
  #     colour_fill(adjacent, colour) if pixel_colour(adjacent) != colour
  #   end
  # end

  def adjacent_pixels_same_colour(coords, colour)
    x, y = coords
    candidates = [[x-1, y], [x+1, y], [x, y-1], [x, y+1]]
    candidates.select do |candidate|
      self.contains?(candidate) && pixel_colour(candidate) == colour
    end
  end

  def transpose
    @chars = @chars.transpose
  end

  def to_s
    @chars.map { |row| "#{row.join('')}\n" }.join('')
  end

end
