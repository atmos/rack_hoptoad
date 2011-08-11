require 'rubygems/package_task'
require 'rubygems/specification'
require 'rspec/core/rake_task'
require 'date'
require 'bundler'

Bundler.setup(:runtime, :test)
Bundler.require(:runtime, :test)

require 'lib/rack/hoptoad_version'

GEM = "rack_hoptoad"
GEM_VERSION = Rack::Hoptoad::VERSION
AUTHOR = "Corey Donohoe"
EMAIL = "atmos@atmos.org"
HOMEPAGE = "http://github.com/atmos/rack_hoptoad"
SUMMARY = "A gem that provides hoptoad notifications from rack"

spec = Gem::Specification.new do |s|
  s.name             = GEM
  s.version          = GEM_VERSION
  s.platform         = Gem::Platform::RUBY
  s.has_rdoc         = true
  s.extra_rdoc_files = ["LICENSE", 'TODO']
  s.summary          = SUMMARY
  s.description      = s.summary
  s.author           = AUTHOR
  s.email            = EMAIL
  s.homepage         = HOMEPAGE

  s.add_dependency('rack')
  s.add_dependency('toadhopper', '~>2.0.0')
  s.require_path = 'lib'
  s.files = %w(LICENSE README.md Rakefile TODO) + Dir.glob("{lib,specs}/**/*.rb") + ["#{GEM}.gemspec"]
end

Gem::PackageTask.new(spec) do |pkg|
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

task :default => 'rack_hoptoad:spec'

namespace :rack_hoptoad do
  desc "Run unit specifications"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w(-fs --color)
    t.pattern = "spec/*_spec.rb"

    t.rcov_opts = []
    t.rcov_opts << '--exclude' << 'spec,.bundle,.rvm'
    t.rcov = ENV.has_key?('NO_RCOV') ? ENV['NO_RCOV'] != 'true' : true
    t.rcov_opts << '--text-summary'
    t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
  end
end
