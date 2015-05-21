#
require '../lib/ban'
require '../lib/mas'
include Col

#
require 'active_record'

#create table bandb(id int auto_increment, dump char(34) unique not null, index(id));
ActiveRecord::Base.establish_connection(
    host:     'localhost',
    database: 'othe20',
    adapter: 'mysql2',
    username: 'root',
    password: '',
)
#ActiveRecord::Base.logger = Logger.new($stderr)
#ActiveRecord::Base.logger.level = 0

class BanDB < ActiveRecord::Base
  self.table_name = 'bandb'
  self.primary_key = 'id'
end

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
  BanDB.transaction do
    nxbans.each do |n|
      next if BanDB.where(dump: n.dump).first
      p [n.olddump, n.wait, n.place, n.dump, n.counts]
      db = BanDB.new
      db.dump = n.dump
      db.save
    end
  end
  ban = nxbans.sample
end
