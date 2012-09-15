# encoding: UTF-8
class RecordObserver < ActiveRecord::Observer
  observe :record
  def after_create(record)
    # puts "test"
    record.delay.create_stream_gcm(record)
    # friends = record.user.friends.uniq{|u| u.id }
    # friends.each do |f|

    #   stream = Stream.new
    #   stream.user = f
    #   stream.record_id = record.id
    #   stream.stream_type = 1
    #   stream.save

    #   next unless f.registration_id
    #   device = Gcm::Device.find_by_registration_id(f.registration_id)
    #   unless device
    #     device = Gcm::Device.new
    #     device.registration_id = f.registration_id
    #     device.save
    #   end
    #   notification = Gcm::Notification.new
    #   notification.device = device
    #    # notification.data = {:registration_ids => [f.registration_id], :data => {:message_text => record.user.name + "說 \"" + record.movie.name + "\"" + record.comment}}
    #   notification.collapse_key = "updates_available"
    #   notification.data = {
    #     :registration_ids => [f.registration_id], 
    #     :data => {
    #       :type => 1,
    #       :user_name => record.user.name,
    #       :user_id => record.user.id,
    #       :comment => record.comment,
    #       :score => record.score,
    #       :movie_name => record.movie.name,
    #       :movie_id => record.movie.id
    #     }
    #   }
    #   notification.save
    # end
    # Gcm::Notification.send_notifications
  end
end
