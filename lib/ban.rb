SIRO=2
KURO=3

class Mas
  attr_reader :x,:y,:c
  def inspect
    [@x,@y]
  end
  def initialize(x,y)
    @x = x
    @y = y
    @c = 0
    if x<0 || y<0
      self
    else
      nil
    end
  end
  def adr
    @y*8+@x
  end
  def self.adr(a)
    x=a%8
    y=a/8
    Mas.new(x,y)
  end
  def around
    [
        Mas.new(@x+1,@y+1),
        Mas.new(@x+1,@y),
        Mas.new(@x+1,@y-1),
        Mas.new(@x,  @y+1),
        Mas.new(@x,  @y-1),
        Mas.new(@x-1,@y+1),
        Mas.new(@x-1,@y),
        Mas.new(@x-1,@y-1),
    ]
  end
end

class Ban
  def initialize(azbz)
    az,bz = azbz.unpack('a8a8')
    a0 = az.unpack('B8'*8).map{|x|x.chars.map(&:to_i)}
    b0 = bz.unpack('B8'*8).map{|x|x.chars.map(&:to_i)}
    @b = a0.zip(b0).map{|a1,b1|a1.zip(b1).map{|a2,b2|a2|(b2*2)}}
  end

  def print
    @b.each{|r|p r}
    nil
  end

  def pset(x,y,c)
    @b[x][y]=c
  end

  def searchxxx(c)
    ps = []
    8.times do |x|
      8.times do |y|
        ps << [x,y] if @b[x][y] == c
      end
    end
    ps
  end
  def search(c)
    ps = []
    8.times do |x|
      8.times do |y|
        ps << Mas.new(x,y) if @b[x][y] == c
      end
    end
    ps
  end

  def around(x,y)
    [
        [x+1,y+1],
        [x+1,y],
        [x+1,y-1],
        [x,  y+1],
        [x,  y-1],
        [x-1,y+1],
        [x-1,y],
        [x-1,y-1]
    ]
  end

  def taketurn(ps)
    ps.map(&:around).flatten.map(&:adr).uniq.map{|a|Mas.adr(a)}
  end

end


z = [''].pack('a16')
ban = Ban.new(z)
ban.pset(3,3,KURO)
ban.pset(4,4,KURO)
ban.pset(4,3,SIRO)
ban.pset(3,4,SIRO)
ban.print
puts

nx = ban.search(SIRO)
p nx
p ban.taketurn(nx)


