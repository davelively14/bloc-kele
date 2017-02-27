require 'kele'
require 'bundler/setup'
require 'vcr'
require 'webmock/rspec'

Bundler.setup
WebMock.disable_net_connect!(allow_localhost: true)

env_file = File.join(File.dirname(__FILE__), 'config', 'local_env.yml')
YAML.load(File.open(env_file)).each do |key, value|
  ENV[key.to_s] = value
end if File.exists?(env_file)

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|

end
