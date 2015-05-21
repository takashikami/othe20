#
require '../lib/ban'
require '../lib/mas'
include Col

ban = Ban.new
ban[0,0]=KURO
ban[0,1]=KURO
ban[1,0]=KURO
ban[1,1]=KURO
ban.turn = KURO
p ban.turn
ban.printban

nxs = ban.calc_placeables
if nxs.empty?
  p ban.taketurn
  nxs = ban.calc_placeables
end
if nxs.empty?
  p "game set"
else
  ban.reversi(nxs.first).printban
end

exit


ban = Ban.new
ban[3,3]=KURO
ban[4,4]=KURO
ban[4,3]=SIRO
ban[3,4]=SIRO
ban[3,5]=SIRO
ban[3,6]=SIRO
ban[4,6]=KURO
ban.printban
puts

nx = ban.check(3,7)
ban = ban.reversi(nx)
p [ban.turn, nx.first, ban.dump]
Ban.load(ban.dump).printban
puts

loop do
  break unless ban.counts[0] > 0
  ban.taketurn
  nx = ban.placeables.first
  ban = ban.reversi(nx)
  p [ban.turn, nx.first, ban.dump]
  ban.printban
  p ban.counts
  puts
end
