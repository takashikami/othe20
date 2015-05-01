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
