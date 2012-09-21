class Record < ActiveRecord::Base
  belongs_to :movie, :counter_cache => true
  belongs_to :user, :counter_cache => true
  has_many :comments, :dependent => :destroy
  has_many :streams, :dependent => :delete_all

  has_many :user_love_record_ships
  has_many :be_loved_by_users, :through => :user_love_record_ships , :source => :user
  
  attr_accessible :comment,:score, :movie_id, :user_id
  scope :friend_records, lambda { |user| where('user_id in (?)', user.friends) if user.friends.size > 0 }
  scope :by_updated, order('updated_at DESC')
  scope :by_updated_asc, order('updated_at ASC')
  scope :by_created, order('created_at DESC')
  scope :by_id_asc, order('id ASC')
  scope :movie_record, lambda { |movies| where('movie_id in (?)', movies) }


  def create_stream_gcm(record)
    logger.info("............delayjob record start............")
    logger.info("............delayjob record start............")
    logger.info("............delayjob record start............")
    logger.info("............delayjob record start............")
    logger.info("............delayjob record start............")
    logger.info("............delayjob record start............")
    logger.info("............delayjob record start............")
    logger.info("............delayjob record start............")
    
    friends = record.user.friends.uniq{|u| u.id }
    friends.each do |f|

      stream = Stream.new
      stream.user = f
      stream.record_id = record.id
      stream.stream_type = 1
      stream.stream_user_id = record.user_id
      stream.movie_id = record.movie_id
      stream.save

      next unless f.registration_id
      device = Gcm::Device.find_by_registration_id(f.registration_id)
      unless device
        device = Gcm::Device.new
        device.registration_id = f.registration_id
        device.save
      end
      notification = Gcm::Notification.new
      notification.device = device
       # notification.data = {:registration_ids => [f.registration_id], :data => {:message_text => record.user.name + "說 \"" + record.movie.name + "\"" + record.comment}}
      notification.collapse_key = "updates_available"
      notification.data = {
        :registration_ids => [f.registration_id], 
        :data => {
          :type => 1,
          :user_name => record.user.name,
          :user_id => record.user.id,
          :comment => record.comment,
          :score => record.score,
          :movie_name => record.movie.name,
          :movie_id => record.movie.id
        }
      }
      notification.save
    end
    Gcm::Notification.send_notifications
  end

end
