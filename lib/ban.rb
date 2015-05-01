class Ban
  def initialize(az, bz)
    @a = az.unpack('B8'*8).map{|x|x.chars.map(&:to_i)}
    @b = bz.unpack('B8'*8).map{|x|x.chars.map(&:to_i)}
  end

  def print
    x = @a.zip(@b).map{|a,b|a.zip(b).map{|aa,bb|aa|(bb*2)}}
    x.each{|r|p r}
    nil
  end

  def pset(x,y,c)
    @a[x][y]=c
    @b[x][y]=1
  end
end

SIRO=0 #白
KURO=1 #黒

z = [''].pack('a8')
ban = Ban.new(z,z)
ban.pset(3,3,KURO)
ban.pset(4,4,KURO)
ban.pset(4,3,SIRO)
ban.pset(3,4,SIRO)
ban.print
puts


