Gem::Specification.new do |s|
	s.name = 'active_csv'
	s.version = '0.1.0'
	s.add_dependency('activemodel', '>= 3.0.0')
	s.summary = 'Inteds to allow you to work with csv data files with an API ActiveRecord-like'
	s.description = 'Inteds to allow you to work with csv data files with an API ActiveRecord-like, but still very limited.'
	s.files = `git ls-files`.split("\n")
	s.homepage = 'http://github.com/marcofognog/active_csv'
  s.platform = Gem::Platform::RUBY
	s.authors = ["Marco Antonio Fogaça Nogueira"]
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7")
  s.email = ["marcofognog@gmail.com"]
  s.require_paths = ["lib"]
end
