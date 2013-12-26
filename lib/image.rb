class Image

  def initialize(m, n)
    @m = m
    @n = n
    @chars = Array.new(m * n, 'O')
  end

  def to_s
    (1..@n).inject('') { |string, num| string << "#{'O' * @m}\n"}.chomp
  end



end
