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
ban.pset(3,5,SIRO)
ban.pset(3,6,SIRO)
ban.pset(4,6,KURO)
ban.print
puts

tern = KURO
nxs = ban.search(SIRO).map(&:around).flatten.uniq.select{|m|m.c==0}
nxcans = nxs.map do |nx|
  nxarounds = nx.around.select{|mx|mx.c==SIRO}
  revs = []
  nxarounds.each do |nxa|
    #dx,dy = nx.vector(nxa)
    dx,dy = [nxa.x-nx.x, nxa.y-nx.y]
    rev = [nxa]
    (2..8).each do |i|
      reva = ban.mget(nx.x+dx*i,nx.y+dy*i)
      case reva.c
        when SIRO
          rev << reva
        when KURO
          #p "#{i} GET #{nx.inspect} #{rev.map(&:inspect)} #{reva.inspect}"
          break
        when 0
          rev = []
          break
        when nil
          rev = []
          break
      end
    end
    revs.concat(rev)
  end
  [nx, revs.flatten] unless revs.flatten.empty?
  #{nx => revs.flatten}
end
nxcans.select{|nx|nx}.each{|nx|p [nx[1].size, nx]}

#ban.taketurn(nx)
#p ban.mget(0,0).around