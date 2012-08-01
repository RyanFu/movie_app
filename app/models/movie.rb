class Movie < ActiveRecord::Base
  belongs_to :theater
  has_many :records

  has_many :movie_theater_ships
  has_many :in_theaters, :through => :movie_theater_ships, :source => :theater

  serialize :actors
  serialize :directors
   
  attr_accessible :name, :name_en,:intro,:poster_url,:release_date, :running_time, :level_url,:actors,:directors

  scope :first_round, where(["is_first_round = ? ", true ])
  scope :second_round, where(["is_second_round = ? ", true ])

  def find_friends_records friends
    r = []
    records.each do |item|
      r << item if friends.include? item.user
    end
    r
  end
end
