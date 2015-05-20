class Mas
  attr_accessor :x,:y,:b,:c

  def inspect
    [@x,@y]
  end

  def initialize(x,y,b,c=0)
    @b = b
    @x = x
    @y = y
    @c = c
  end

  def self.pos(x,y,b,c=0)
    Mas.new(x,y,b,c) unless x<0 || y<0
  end

  def self.adr(a,b,c=0)
    x=a%8
    y=a/8
    Mas.new(x,y,b,c) unless x<0 || y<0
  end

  def around
    [
        @b[@x+1,@y+1],
        @b[@x+1,@y  ],
        @b[@x+1,@y-1],
        @b[@x,  @y+1],
        @b[@x,  @y-1],
        @b[@x-1,@y+1],
        @b[@x-1,@y  ],
        @b[@x-1,@y-1],
    ].compact
  end

  def reversi
    @c = @b.turn
  end
end
