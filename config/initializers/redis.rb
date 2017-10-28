# require "redis"
require 'yaml'
# rx = /port.(\d+)/
# redis_conf = File.read(Rails.root.join("config/redis", "#{Rails.env}.conf"))
# port = rx.match(redis_conf)[1]
# res = `ps aux | grep redis-server | grep -v grep`
# unless res.include?("redis-server")
#   `redis-server #{Rails.root.join("config/redis", "#{Rails.env}.conf")}`
#   res = `ps aux | grep redis-server | grep -v grep`
#   raise "Couldn't start redis" unless res.include?("redis-server") && res.include?(":#{port}")
# end


conf_file = File.join('config', 'redis.yml')
conf = YAML.load(File.read(conf_file))
$redis = Redis.new(conf[Rails.env.to_s])

# rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
# rails_env = ENV['RAILS_ENV'] || 'development'

# Resque.redis = YAML.load_file(rails_root + '/config/redis.yml')[rails_env]