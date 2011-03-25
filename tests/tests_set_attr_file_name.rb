require 'test/unit'
require 'test_helpers'
require 'car'
require 'rubygems'
require 'active_support/hash_with_indifferent_access'

class SetAttrFileNameTests < Test::Unit::TestCase
	include TestHelpers
	
	def test_delete
		delete_attr_file
		create_different_attr_file
		before = Car.all.length
		car = Car.new(:year=>1999)
		car.brand = "WV"
		car.color = "red again"
		assert car.save
		assert_equal before, Car.all.length
	end

end
