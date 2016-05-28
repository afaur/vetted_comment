$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'vettedcomment'
  s.version     = VettedComment::VERSION
  s.platform    = Gem::Platform::RUBY

  s.required_ruby_version = '2.1.0'
  s.required_rubygems_version = '>= 2'

  s.files = Dir['README.md', 'lib/**/*']
  s.require_path = 'lib'

  s.add_development_dependency('rake')
  s.add_development_dependency('minitest')
end

