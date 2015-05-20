#
require '../lib/ban'
require '../lib/mas'
include Col

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

nxs = ban.placeables
nx = nxs.select{|canx|[canx.first.x,canx.first.y]==[3,7]}
nx = ban.check(3,7)
p nx

nx.each(&:reversi)
ban.printban
puts
p ban.taketurn
ban.placeables.first.each(&:reversi)
ban.printban
