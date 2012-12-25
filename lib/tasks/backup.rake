# encoding: utf-8
namespace :backup do
  task :dropbox_backup => :environment do
    require 'dropbox_sdk'
    APP_KEY = '5zxihfd5ad4rvjo'
    APP_SECRET = 'ti24h3yqwt4dsgf'
    ACCESS_TYPE = :app_folder
    session = DropboxSession.new(APP_KEY, APP_SECRET)
    session.set_access_token "hn7fbgsfwmfgo3q","gc1k1bqs3o9ae16" 
    client = DropboxClient.new(session, ACCESS_TYPE)
    file = open('Gemfile')
    response = client.put_file('/data.yml', file)
  end
end
