require 'bundler/setup'
Bundler.setup

require 'kele'

env_file = File.join(File.dirname(__FILE__), 'config', 'local_env.yml')
YAML.load(File.open(env_file)).each do |key, value|
  ENV[key.to_s] = value
end if File.exists?(env_file)

RSpec.configure do |config|

end
