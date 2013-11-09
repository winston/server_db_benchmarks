ENV["RACK_ENV"] ||= "development"

config = YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]
ActiveRecord::Base.establish_connection(config)
