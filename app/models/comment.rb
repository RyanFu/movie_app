class Comment < ActiveRecord::Base
  attr_accessible :record_id, :user_id, :text
  belongs_to :record, :counter_cache => true
  belongs_to :user
  has_many :streams, :dependent => :delete_all

  def create_stream_gcm(comment)
    logger.info("............delayjob comment start......")
    logger.info("............delayjob comment start......")
    logger.info("............delayjob comment start......")
    logger.info("............delayjob comment start......")
    logger.info("............delayjob comment start......")
    logger.info("............delayjob comment start......")
    logger.info("............delayjob comment start......")
    logger.info("............delayjob comment start......")

    record = comment.record
    users = comment.record.comments.map{|c| c.user}
    users << record.user
    users = users.uniq{|u| u.id }.select{|u| u != comment.user}
    users.each do |f|
      
      stream = Stream.new
      stream.user = f
      stream.comment_id = comment.id
      stream.stream_type = 2
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
          :type => 2,
          :user_name => comment.user.name,
          :user_id => comment.user.id,
          :record_id => record.id,
          :comment_text => comment.text,
          :movie_name => record.movie.name,
          :movie_id => record.movie.id
        }
      }
      notification.save
    end
    Gcm::Notification.send_notifications
  end
end
