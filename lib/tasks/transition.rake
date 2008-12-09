require 'erb'

namespace :dev do

  desc "Make local develoment site look like the live site"
  task :sync => [:environment] do
    ssh_user = 'ttnz'
    host = 'tt.craigambrose.com'
    home_dir = '/home/ttnz'

    db_config = YAML::load(ERB.new(IO.read('config/database.yml')).result)

    system "ssh #{ssh_user}@#{host} \"./dump_data.sh\""
    system "rsync -az --progress #{ssh_user}@#{host}:#{home_dir}/dump.sql ./db/production_data.sql"
    system "mysql -u #{db_config['development']["username"]} -p#{db_config['development']["password"]} #{db_config['development']["database"]} < ./db/production_data.sql"
    system "rm ./db/production_data.sql"
  end

end