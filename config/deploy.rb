require "bundler/capistrano"

#server "208.82.101.23", :web, :app, :db, primary: true
#server "ec2-107-20-152-41.compute-1.amazonaws.com", :web, :app, :db, primary: true
server "ec2-184-73-140-71.compute-1.amazonaws.com", :web, :app, :db, primary: true
#server "107.20.152.41", :web, :app, :db, primary: true

set :application, "usaprays"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, 'git'
set :repository,  "git@github.com:capitolcom/usaprays.git"
set :branch, 'master'
#set :branch, 'move_to_aws'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# if you want to clean up old releases on each deploy (keep last 5 releases)
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/config/initializers"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/initializers/mail_chimp.example.rb"), "#{shared_path}/config/initializers/mail_chimp.rb"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/initializers/mail_chimp.rb #{release_path}/config/initializers/mail_chimp.rb"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as upstream origin/#{branch}"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
