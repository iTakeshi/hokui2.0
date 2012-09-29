ssh_options[:forward_agent] = true
ssh_options[:port] = '1122'
default_run_options[:pty] = true

set :scm, :git
set :repository, "git@github.com:iTakeshi/hokui2.0.git"

set :deploy_via, :remote_cache
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production

task :staging do
  set :user, 'itakeshi'
  set :domain, 'www.itakeshi.net'
  set :port, '1122'
  set :application, 'hokui'
  set :branch, 'development'
end

task :production do
  puts "\n\e[0;31m Are you REALLY sure you want to deploy to production? \e[0m\n"
  proceed = STDIN.gets[0..0] rescue nil
  exit unless proceed == 'y' || proceed == 'Y'

  set :default_environment, {
    'PATH' => '/home/ruby-passenger/.rvm/gems/ruby-1.9.3-p194@global/bin:/home/ruby-passenger/.rvm/gems/ruby-1.9.3-p194/bin:/home/ruby-passenger/.rvm/rubies/ruby-1.9.3-p194/bin:/home/ruby-passenger/.rvm/bin:$PATH',
    'GEM_HOME' => '/home/ruby-passenger/.rvm/gems/ruby-1.9.3-p194',
    'GEM_PATH' => '/home/ruby-passenger/.rvm/gems/ruby-1.9.3-p194:/home/ruby-passenger/.rvm/gems/ruby-1.9.3-p194@global',
    'BUNDLE_PATH' => '/home/ruby-passenger/.rvm/gems/ruby-1.9.3-p194/bin'
  }
  set :user, 'ruby-passenger'
  set :domain, 'hokui93.net'
  set :port, '1122'
  set :application, 'hokui'
  set :branch, 'master'
end

set :deploy_to, "/var/app/rails/#{application}"
role :web, domain                   # Your HTTP server, Apache/etc
role :app, domain                   # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

require 'bundler/capistrano'
