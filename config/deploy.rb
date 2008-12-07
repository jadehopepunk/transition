set :application, "ttnz"

set :deploy_to, "/home/ttnz/public_html/ttnz"

set :user, 'ttnz'

set :scm, :git
set :repository, "git://github.com/craigambrose/transition.git"
set :scm_verbose, true
default_run_options[:pty] = true

role :app, "tt.craigambrose.com"
role :web, "tt.craigambrose.com"
role :db,  "tt.craigambrose.com", :primary => true

after "deploy:update_code", "db:symlink"
after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"

namespace :db do
  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
    run "ln -nfs #{release_path}/tmp/pin_images #{release_path}/public/pin_images" 
  end
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end