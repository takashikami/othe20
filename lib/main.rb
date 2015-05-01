#
require '../lib/ban'
require '../lib/mas'

SIRO=2
KURO=3
NONE=0

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
wait = SIRO

nxs = ban.search(wait).map(&:around).flatten.uniq.select{|m|m.c==0}

nxcans = nxs.map do |nx|
  nxarounds = nx.around.select{|mx|mx.c==wait}
  revs = []
  nxarounds.each do |nxa|
    dx,dy = [nxa.x-nx.x, nxa.y-nx.y]
    rev = [nxa]
    (2..8).each do |i|
      reva = ban.mget(nx.x+dx*i,nx.y+dy*i)
      case reva.c
        when wait
          rev << reva
        when tern
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
end
nxcans.compact.each{|nx|p [nx[1].size, nx]}
