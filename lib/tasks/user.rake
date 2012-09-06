# encoding: utf-8
namespace :user do
  task :update_user_friends_ship => :environment do
      User.find_in_batches(:batch_size => 1000) do |users|
        users.each do |u|
          puts u.name
          u.facebook_friends_use_app
        end
      end
  end
end