class User < ActiveRecord::Base

  has_many :records

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible  :email, :password, :password_confirmation, :remember_me, :fb_id, :fb_token
  # attr_accessible :title, :body

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
    return @friends if @friends
    users = []
    facebook { |fb| @friends = fb.fql_query("SELECT uid2 FROM friend WHERE uid1=me()")}
    return [] unless @friends
    uid2s = @friends.map{|item| item["uid2"]}
    @friends = User.where('fb_id in (?) ', uid2s)
  end
end
