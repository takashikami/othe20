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

#exit


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
oldban = ban
ban = oldban.reversi(nx)
ban.taketurn
p [oldban.dump, ban.wait, nx.first, ban.dump]
p '='*15
Ban.load(ban.dump).printban
p '='*15
puts

ban = Ban.new
ban[3,3]=KURO
ban[4,4]=KURO
ban[4,3]=SIRO
ban[3,4]=SIRO
loop do
  break unless ban.counts[0] > 0
  nxs = if ban.calc_placeables.empty?
    ban.taketurn
    ban.calc_placeables
  else
    ban.placeables
  end
  break if nxs.empty?

  nxbans = nxs.map{|nx|ban.reversi(nx)}
  nxbans.each{|n|p [n.olddump, n.wait, n.place, n.dump, n.counts]}
  nxban = nxbans.sample
  nxban.printban
  ban = nxban
end
