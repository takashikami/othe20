#
require '../lib/ban'
require '../lib/mas'
include Col

#
require 'active_record'

=begin
create table bandb(
  id bigint auto_increment primary key,
  olddump char(34) not null,
  dump char(34) unique not null,
  stat smallint not null default 0,
  turn smallint,
  placex smallint,
  placey smallint,
  count0 smallint,
  count2 smallint,
  count3 smallint,
  updated_on timestamp,
  created_on timestamp,
  index(olddump)
);
=end
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

if BanDB.count == 0
  ban = Ban.new
  ban[3,3]=KURO
  ban[4,4]=KURO
  ban[4,3]=SIRO
  ban[3,4]=SIRO

  db = BanDB.new
  db.dump = ban.dump
  db.olddump = '00'*16+'00'
  db.turn = KURO
  db.count0 = ban.counts[0]
  db.count2 = ban.counts[2]
  db.count3 = ban.counts[3]
  db.save!
end

loop do
  nxs = nil
  old = nil
  BanDB.transaction do
    old = BanDB.where(stat: 0).lock(true).first
    break if old.nil?
    ban = Ban.load(old.dump)
    ban.printban
    unless ban.counts[0] > 0
      ban.printban
      old.stat = 3 #gameset
      old.save!
      next
    end
    nxs = if ban.calc_placeables.empty?
      ban.taketurn
      ban.calc_placeables
    else
      ban.placeables
    end
    if nxs.empty?
      ban.printban
      old.stat = 3 #gameset
      old.save!
      next
    end
    old.stat = 1
    old.save!
  end

  nxbans = nxs.map{|nx|ban.reversi(nx)}
  BanDB.transaction do
    nxbans.each do |n|
      next if BanDB.where(dump: n.dump).first
      p [n.olddump, n.wait, n.place, n.dump, n.counts]
      db = BanDB.new
      db.dump = n.dump
      db.olddump = n.olddump
      db.turn = n.wait
      db.placex = n.place[0]
      db.placey = n.place[1]
      db.count0 = n.counts[0]
      db.count2 = n.counts[2]
      db.count3 = n.counts[3]
      db.save
      oldban = BanDB.find(old.id)
      oldban.stat = 2
      oldban.save
    end
  end
  ban = nxbans.sample
end
