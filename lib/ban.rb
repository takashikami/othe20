SIRO=2
KURO=3

class Mas
  attr_accessor :x,:y,:c
  def inspect
    [@x,@y]
  end
  def initialize(x,y,b)
    @b = b
    @x = x
    @y = y
    @c = 0
  end
  def adr
    @y*8+@x
  end
  def self.pos(x,y,b)
    return if x<0 || y<0
    Mas.new(x,y,b)
  end
  def self.adr(a,b)
    x=a%8
    y=a/8
    Mas.new(x,y,b)
  end
  def around
    @b.m.map(&:c)
    [
        @b.mget(@x+1,@y+1),
        @b.mget(@x+1,@y),
        @b.mget(@x+1,@y-1),
        @b.mget(@x,  @y+1),
        @b.mget(@x,  @y-1),
        @b.mget(@x-1,@y+1),
        @b.mget(@x-1,@y),
        @b.mget(@x-1,@y-1),
    ].select{|m|m}
  end
  def vector(p)
    [p.x-@x,p.y-@y]
  end
  def vget(v,n)

  end
end

class Ban
  attr_accessor :m
  def initialize
    @m = (0..63).to_a.map{|a|Mas.adr(a,self)}
  end

  def print
    @m.map(&:c).map(&:to_s).join.unpack('a8'*8).each{|r|p r}
    nil
  end

  def mget(x,y)
    @m[x+8*y] unless x<0 || y<0
  end
  def pset(x,y,c)
    @m[x+8*y].c=c
  end

  def search(c)
    @m.select{|m|m.c == c}
  end

  def taketurn(ps)
    around = ps.map(&:around).flatten.uniq
  end

end


z = [''].pack('a16')
ban = Ban.new
ban.pset(3,3,KURO)
ban.pset(4,4,KURO)
ban.pset(4,3,SIRO)
ban.pset(3,4,SIRO)
ban.print
puts

tern = KURO
nx = ban.search(SIRO).map(&:around).flatten.uniq.select{|m|m.c==0}
nx.map do |nxx|
  nn = nxx.around.select{|mx|mx.c==SIRO}
  nn.each do |nnn|
    dx,dy = nnn.vector(nxx)
    rev = [nnn]
    (2..8).each do |i|
      reva = ban.mget(nxx.x+dx,nxx.y+dy)
      p ["reva",reva,reva.c]
      case reva.c
        when SIRO
          rev << reva
          p "#{i} SIRO"
        when KURO
          p "#{i} GET"
          break
        when 0
          p "#{i} SUKA"
          rev = []
          break
        when nil
          p "#{i} KABE"
          rev = []
          break
      end
    end
    p ["rev",rev]
  end
  p [nxx,nn]
end
#ban.taketurn(nx)
#p ban.mget(0,0).around