# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bitch}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Sanders"]
  s.date = %q{2009-01-20}
  s.description = %q{A very simple library for building binary data in a declarative manner}
  s.email = %q{sanderjd@gmail.com}
  s.files = ["README", "Rakefile", "demo.rb", "lib/bitch.rb", "lib/bits.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/sanderjd/bitch}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Bitch - A simple binary message building helper}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
