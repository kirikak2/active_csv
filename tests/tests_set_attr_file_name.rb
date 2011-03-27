require 'test/unit'
require 'test_helpers'
require 'car_with_set_attr'
require 'rubygems'
require 'active_support/hash_with_indifferent_access'

class SetAttrFileNameTests < Test::Unit::TestCase
	include TestHelpers
	
	def test_set_attr_file_name
		delete_attr_file
		create_different_attr_file
		before = Car2.all.length
		car = Car2.new(:year=>1999)
		car.brand = "WV"
		car.color = "red again"
		assert car.save
		assert_equal before+1, Car2.all.length
		delete_different_attr_file
		create_attr_file
	end

end
