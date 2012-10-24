class News < ActiveRecord::Base
  # attr_accessible :title, :body
  scope :by_id_desc, order('id DESC')
  belongs_to :user
end
