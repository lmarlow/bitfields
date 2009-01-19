begin
  require 'rubygems'
rescue Exception
  puts 'RubyGems is not install. See http://www.rubygems.org/read/chapter/3 for instructions.'
end

begin
  require 'spec/rake/spectask'

  Spec::Rake::SpecTask.new do |t|
    t.spec_opts = ['-c']
    t.libs << 'lib'
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true 
  end
rescue Exception 
  puts 'RSpec not available. Install it with: sudo gem install rspec'
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "bitch"
    s.summary = "Bitch - A simple binary message building helper"
    s.description = "A very simple library for building binary data in a declarative manner"
    s.email = 'sanderjd@gmail.com'
    s.homepage = 'http://github.com/sanderjd/bitch'
    s.authors = ['James Sanders']
    s.has_rdoc = true
    s.files = ["README",
               "Rakefile",
               "demo.rb",
               "lib/bitch.rb", 
               "lib/bits.rb"]
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com'
end
