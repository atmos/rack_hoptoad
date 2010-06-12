require 'rack'
require 'erb'
require 'toadhopper'

module Rack
  # Catches all exceptions raised from the app it wraps and
  # posts the results to hoptoad.
  class Hoptoad
    VERSION = '0.1.4.a'

    attr_accessor :api_key, :environment_filters, :report_under, :rack_environment, :notifier_class, :failsafe

    def initialize(app, api_key = nil, rack_environment = 'RACK_ENV')
      @app                 = app
      @api_key             = api_key
      @report_under        = %w(staging production)
      @rack_environment    = rack_environment
      @environment_filters = %w(AWS_ACCESS_KEY  AWS_SECRET_ACCESS_KEY AWS_ACCOUNT SSH_AUTH_SOCK)
      @notifier_class      = Toadhopper
      @failsafe            = $stderr
      yield self if block_given?
    end

    def call(env)
      status, headers, body =
        begin
          @app.call(env)
        rescue StandardError, LoadError, SyntaxError => boom
          notified = send_notification boom, env
          env['hoptoad.notified'] = notified
          raise
        end
      send_notification env['rack.exception'], env if env['rack.exception']
      [status, headers, body]
    end

    def environment_filter_keys
      @environment_filters.flatten
    end
  private
    def report?
      report_under.include?(rack_env)
    end

    def send_notification(exception, env)
      return true unless report?
      request      = Rack::Request.new(env)

      options = {
        :api_key           => api_key,
        :url               => "#{request.scheme}://#{request.host}#{request.path}",
        :params            => request.params,
        :framework_env     => rack_env,
        :notifier_name     => 'Rack::Hoptoad',
        :notifier_version  => VERSION,
        :session           => env['rack.session']
      }

      result = toadhopper.post!(exception, options, {'X-Hoptoad-Client-Name' => 'Rack::Hoptoad'})
      result.errors.empty?
    rescue Exception => e
      return unless @failsafe
      @failsafe.puts "Fail safe error caught: #{e.class}: #{e.message}"
      @failsafe.puts e.backtrace
      @failsafe.puts "Exception is #{exception.class}: #{exception.message}"
      @failsafe.puts exception.backtrace
    end

    def rack_env
      ENV[rack_environment] || 'development'
    end

    def toadhopper
      toad         = @notifier_class.new(api_key)
      toad.filters = environment_filter_keys
      toad
    end

    def extract_body(env)
      if io = env['rack.input']
        io.rewind if io.respond_to?(:rewind)
        io.read
      end
    end
  end
end
