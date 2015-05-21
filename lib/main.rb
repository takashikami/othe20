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

nx = ban.check(3,7)
ban = ban.reversi(nx)
p [ban.turn, nx.first, ban.dump]
Ban.load(ban.dump).printban
puts

p ban.taketurn
nx = ban.placeables.first
ban = ban.reversi(nx)
p [ban.turn, nx.first, ban.dump]
ban.printban