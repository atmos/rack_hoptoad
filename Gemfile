source :gemcutter

group :runtime do
  gem 'rack'
  gem 'toadhopper', '~>1.0.1'
end

group :test do
  gem 'rake'
  gem 'rspec',      :require => 'spec'
  if RUBY_VERSION =~ /^1\.9/
    gem 'ruby-debug19'
  else
    gem 'ruby-debug'
  end
  gem 'rcov'
  gem 'bundler',   '>0.7.2'
end
