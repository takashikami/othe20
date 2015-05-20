module Col
  NONE=0
  SIRO=2
  KURO=3
end
class Ban
  include Col
  attr_accessor :m, :turn, :wait

  def initialize
    @m = (0..63).to_a.map{|a|Mas.adr(a,self)}
    @turn = KURO
    @wait = SIRO
  end

  def initialize_copy(obj)
    @m = obj.m.map{|a|Mas.pos(a.x,a.y,self,a.c)}
  end

  def printban
    @m.map(&:c).map(&:to_s).join(' ').unpack('a16'*8).each{|r|p r.strip}
    nil
  end

  def taketurn
    last = @wait
    @wait = @turn
    @turn = last
  end

  def [](x,y)
    @m[x+8*y] unless x<0 || y<0
  end

  def []=(x,y,c)
    @m[x+8*y].c=c
  end

  def search(c)
    @m.select{|m|m.c == c}
  end

  def check(x,y)
    placeables.select{|canx|canx.first.inspect==[x,y]}.first
  end

  def placeables
    @m.select{|m|m.c == @wait}.map(&:around)
        .flatten.uniq.select{|m|m.c==NONE}.map do |nx|
      nxarounds = nx.around.select{|mx|mx.c==@wait}
      revs = []
      nxarounds.each do |nxa|
        dx,dy = [nxa.x-nx.x, nxa.y-nx.y]
        rev = [nxa]
        (2..8).each do |i|
          reva = self[nx.x+dx*i,nx.y+dy*i]
          if reva.nil?
            rev = []
            break
          end
          case reva.c
            when @wait
              rev << reva
            when @turn
              break
            when NONE
              rev = []
              break
          end
        end
        revs.concat(rev)
      end
      [nx, revs].flatten unless revs.flatten.empty?
    end.compact
  end
end
