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

ban.calc_placeables
nx = ban.check(3,7)
p nx

nx.each(&:reversi)
ban.printban
p [ban.turn, nx.first, ban.dump]
puts
p ban.taketurn
nx = ban.calc_placeables.first
nx.each(&:reversi)
ban.printban
p [ban.turn, nx.first, ban.dump]