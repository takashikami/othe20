#
require '../lib/ban'
require '../lib/mas'

ban = Ban.new
ban.pset(3,3,Ban::KURO)
ban.pset(4,4,Ban::KURO)
ban.pset(4,3,Ban::SIRO)
ban.pset(3,4,Ban::SIRO)
ban.pset(3,5,Ban::SIRO)
ban.pset(3,6,Ban::SIRO)
ban.pset(4,6,Ban::KURO)
ban.print
puts

nxs = ban.taketurn
nxs.each{|nx|p nx}

nxs[4].flatten.each do |nx|
  nx.reversi
end
ban.print
puts
ban.turn = Ban::SIRO
ban.wait = Ban::KURO
ban.taketurn.first.flatten.each(&:reversi)
ban.print
