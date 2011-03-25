require 'test/unit'
require 'test_helpers'
require 'car'
require 'rubygems'
require 'active_support/hash_with_indifferent_access'

class Car
	set_attr_file_name "config/csv_attributes_with_other_name.yml"
end

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
		assert_equal before+1, Car.all.length
		#delete_different_attr_file
	end

end
