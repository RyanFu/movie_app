# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_friend_ship do
    direct_friend_id 1
    inverse_friend_id 1
  end
end
