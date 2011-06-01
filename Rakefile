require 'rake/testtask'

desc "Run basic tests"
Rake::TestTask.new("test") do |t|
	t.libs << ["lib","tests", "tests/models"]
	t.test_files = FileList['tests/test*.rb']
	t.verbose = false
	t.warning = false
end
