class Image

  def initialize(m, n)
    @m = m
    @n = n
    @chars = Array.new(m * n, 'O')
  end

  def to_s
    s = ''
    @n.times { s << "#{'O' * @m}\n" }
    s.chomp
  end

end
