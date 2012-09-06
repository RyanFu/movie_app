require 'bundler/capistrano'
# require 'hoptoad_notifier/capistrano'

set :application, "movie_app"
set :rails_env, "production"

set :branch, "master"
set :repository,  "git://github.com/StevenKo/movie_app.git"
set :scm, "git"
set :user, "apps" # 一個伺服器上的帳戶用來放你的應用程式，不需要有sudo權限，但是需要有權限可以讀取Git repository拿到原始碼
set :port, "22"


set :deploy_to, "/home/apps/movie_app"
set :deploy_via, :remote_cache
set :use_sudo, false

role :web, "106.187.101.252"
role :app, "106.187.101.252"
role :db,  "106.187.101.252", :primary => true


namespace :deploy do
  

  task :copy_config_files  do
    db_config = "#{shared_path}/config/database.yml.production"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end
  
  task :update_symlink do
    run "ln -s {shared_path}/public/system {current_path}/public/system"
  end
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

after "deploy:update_code", "deploy:copy_config_files" # 如果將database.yml放在shared下，請打開
after "deploy:create_symlink", "deploy:update_crontab"
# after "deploy:finalize_update", "deploy:update_symlink" # 如果有實作使用者上傳檔案到public/system，請打開