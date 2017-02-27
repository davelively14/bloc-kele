Gem::Specification.new do |s|
  s.name = 'kele'
  s.version = '0.0.1'
  s.date = '2017-02-26'
  s.summary = 'Kele API Client'
  s.description = 'A client for the Bloc API'
  s.authors = ['Dave Lively']
  s.email = 'dlively@resurgens.io'
  s.files = ['lib/kele.rb']
  s.require_paths = ["lib"]
  s.homepage = 'http://rubygems.org/gems/kele'
  s.license = 'MIT'
  s.add_runtime_dependency 'httparty', '~> 0.13'
  s.add_runtime_dependency 'json'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr'
end
