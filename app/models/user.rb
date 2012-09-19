class User < ActiveRecord::Base

  has_many :records
  has_many :comments
  has_many :streams
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible  :email, :password, :password_confirmation, :remember_me, :fb_id, :fb_token
  # attr_accessible :title, :body

  has_many :direct_friends_ship, :foreign_key => 'inverse_friend_id', :class_name => 'UserFriendShip'
  has_many :inverse_friends_ship,  :foreign_key => 'direct_friend_id',   :class_name => 'UserFriendShip'    
  has_many :direct_friends, :through => :direct_friends_ship
  has_many :inverse_friends,  :through => :inverse_friends_ship

  has_many :user_love_record_ships
  has_many :love_records, :through => :user_love_record_ships, :source => :record

  def self.find_for_database_authentication(conditions={})
    self.where("fb_id = ?", conditions[:fb_id]).limit(1).first
  end

  def self.find_for_authentication(conditions={})
    unless conditions[:email] =~ /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i # email regex
      conditions[:fb_id] = conditions.delete("email")
    end
    super
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(fb_token)
    block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
      logger.info e.to_s
      nil

  end

  def facebook_friends_use_app
    # return @friends if @friends
    users = []
    facebook { |fb| @friends = fb.fql_query("SELECT uid2 FROM friend WHERE uid1=me()")}
    # return [] unless @friends
    unless @friends.blank?
      uid2s = @friends.map{|item| item["uid2"]}
      @friends = User.where('fb_id in (?) ', uid2s)

      @friends.each do |f|
        direct_friends << f unless direct_friends.include? f
      end
    end

  end

  def friends
    direct_friends 
  end
end
