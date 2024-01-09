Gem::Specification.new do |s|
  s.name        = "weather_request"
  s.version     = "0.0.0"
  s.summary     = "Weather Request"
  s.description = "A simple request library for weather info for the current and the next 5 days."
  s.authors     = ["Rafael Porto"]
  s.email       = "faielils@gmail.com"
  s.files       = ["lib/weather_request.rb"]
  s.license     = "MIT"

  s.add_runtime_dependency('json', '~> 2.7', '>= 2.7.1')
end
