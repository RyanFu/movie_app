class Campaign < ActiveRecord::Base
  belongs_to  :movie
  # attr_accessible :title, :body
end
