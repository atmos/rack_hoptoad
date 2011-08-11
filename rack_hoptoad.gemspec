# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack_hoptoad}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Corey Donohoe"]
  s.date = %q{2011-08-11}
  s.description = %q{A gem that provides hoptoad notifications from rack}
  s.email = %q{atmos@atmos.org}
  s.extra_rdoc_files = ["LICENSE", "TODO"]
  s.files = ["LICENSE", "README.md", "Rakefile", "TODO", "lib/rack", "lib/rack/hoptoad.rb", "lib/rack/hoptoad_version.rb", "lib/rack/hoptoad_version.rb~"]
  s.homepage = %q{http://github.com/atmos/rack_hoptoad}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{A gem that provides hoptoad notifications from rack}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<toadhopper>, ["~> 2.0.0"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<toadhopper>, ["~> 2.0.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<toadhopper>, ["~> 2.0.0"])
  end
end
