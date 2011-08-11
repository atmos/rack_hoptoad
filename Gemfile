source :gemcutter

group :runtime do
  gem 'rack'
  gem 'toadhopper', '~>2.0.0'
end

group :test do
  gem 'rake'
  gem 'rspec'
  if RUBY_VERSION =~ /^1\.9/
    gem 'ruby-debug19'
  else
    gem 'ruby-debug'
  end
  gem 'rcov'
  gem 'bundler',   '>= 1.0.0'
end
