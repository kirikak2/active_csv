Gem::Specification.new do |s|
	s.name = 'active_csv'
	s.version = '0.0.1'
	s.add_dependency('active_model', '>= 3.0.0')
	s.summary = 'Inteds to allow you to work with csv data files with an API ActiveRecord-like'
	s.description = 'Inteds to allow you to work with csv data files with an API ActiveRecord-like'
	s.files = `git ls-files`.split("\n")
  s.platform = Gem::Platform::RUBY
	s.authors = ["Marco Antonio Fogaça Nogueira"]
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7")
  s.email = ["marcofognog@gmail.com"]
  s.require_paths = ["lib"]
end
