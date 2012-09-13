class Movie < ActiveRecord::Base
  
  has_one  :movie_box_office_ship
  has_many :records

  has_many :movie_theater_ships
  has_many :in_theaters, :through => :movie_theater_ships, :source => :theater

  serialize :actors
  serialize :directors
   
  attr_accessible :name, :name_en,:intro,:poster_url,:release_date, :running_time, :level_url,:actors,:directors

  scope :first_round, where(["is_first_round = ? ", true ])
  scope :second_round, where(["is_second_round = ? ", true ])
  scope :hot, where(["is_hot = ? ", true ])
  scope :comming, where(["is_comming = ? ", true ])

  def find_friends_records friends
    r = []
    records.by_updated.each do |item|
      r << item if friends.include? item.user
    end
    return_record = []
    r.each do |record|
      s = {}
      s["id"] = record.id
      s["comment"] = record.comment
      s["score"] = record.score
      s["user_fb_id"] = record.user.fb_id
      s["user_name"] = record.user.name
      return_record << s
    end
    return_record
  end

  def find_friends_origin_records friends
    r = []
    self.records.by_updated.each do |item|
      r << item if friends.include? item.user
    end
    r
  end
end
