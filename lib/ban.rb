class Ban
  SIRO=2
  KURO=3
  NONE=0

  attr_accessor :m, :turn, :wait

  def initialize
    @m = (0..63).to_a.map{|a|Mas.adr(a,self)}
    @turn = KURO
    @wait = SIRO
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

  def taketurn
    @m.select{|m|m.c == @wait}.map(&:around)
        .flatten.uniq.select{|m|m.c==NONE}.map do |nx|
      nxarounds = nx.around.select{|mx|mx.c==@wait}
      revs = []
      nxarounds.each do |nxa|
        dx,dy = [nxa.x-nx.x, nxa.y-nx.y]
        rev = [nxa]
        (2..8).each do |i|
          reva = mget(nx.x+dx*i,nx.y+dy*i)
          case reva.c
            when @wait
              rev << reva
            when @turn
              break
            when NONE
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
    end.compact
=begin
        .map do |nx|
      p nx
      nxb = Ban.new
      nxb.m=@m.clone
      nxb.print
      puts
      nx.flatten.each{|m|nxb.pset(m.x,m.y,@turn)}
      nxb
=end
  end
end
