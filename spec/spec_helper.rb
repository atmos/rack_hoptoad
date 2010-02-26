require 'bundler'

Bundler.setup(:runtime, :test)
Bundler.require(:test)
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'rack/hoptoad'
require 'rack/mock'

unless ENV['MY_HOPTOAD_API_KEY']
  raise ArgumentError, "You need to export MY_HOPTOAD_API_KEY in your environment to run the tests"
end
