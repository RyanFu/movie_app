# encoding: UTF-8
class RecordObserver < ActiveRecord::Observer
  observe :record
  def after_create(record)
    # puts "test"
    record.delay.create_stream_gcm(record)

    if record.score == 0
       m = record.movie
       m.good_counts = m.good_count + 1
       m.save
    end
  end

  def after_destroy(record)
    if record.score == 0
       m = record.movie
       m.good_counts = m.good_count - 1
       m.save
    end
  end
end
