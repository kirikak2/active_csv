require 'test/unit'
require 'test_helpers'
require 'car'
require 'rubygems'
require 'active_support/hash_with_indifferent_access'

class FindTests < Test::Unit::TestCase
	include TestHelpers
	
	def test_delete
		create_attr_file
	end
end
