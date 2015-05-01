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

  def self.pos(x,y,b)
    return if x<0 || y<0
    Mas.new(x,y,b)
  end

  def self.adr(a,b)
    x=a%8
    y=a/8
    return if x<0 || y<0
    Mas.new(x,y,b)
  end

  def around
    [
        @b.mget(@x+1,@y+1),
        @b.mget(@x+1,@y),
        @b.mget(@x+1,@y-1),
        @b.mget(@x,  @y+1),
        @b.mget(@x,  @y-1),
        @b.mget(@x-1,@y+1),
        @b.mget(@x-1,@y),
        @b.mget(@x-1,@y-1),
    ].compact
  end
end
