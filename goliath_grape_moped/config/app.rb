ENV["RACK_ENV"] ||= "development"

config = YAML::load(File.open('config/mongoid.yml'))[ENV["RACK_ENV"]]
Mongoid.load!("config/mongoid.yml", ENV["RACK_ENV"])

$moped = EM::Synchrony::ConnectionPool.new(size: 20) do
  default = config['sessions']['default']
  Moped::Session.new(default['hosts'], database: default['database'])
end
