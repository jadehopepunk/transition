set :application, "ttnz"

set :deploy_to, "/home/ttnz/public_html/ttnz"

set :user, 'ttnz'

set :scm, :git
set :repository, "git://github.com/craigambrose/transition.git"
set :scm_verbose, true
default_run_options[:pty] = true

role :app, "maps.transitiontowns.org.nz"
role :web, "maps.transitiontowns.org.nz"
role :db,  "maps.transitiontowns.org.nz", :primary => true

after "deploy:update_code", "db:symlink"
after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"

namespace :db do
  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
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