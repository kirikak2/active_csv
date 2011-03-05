require 'test/unit'
require 'test_helpers'
require 'car'

class UpdateAttributesTests < Test::Unit::TestCase
	include TestHelpers

	def test_update_attr_three_attr
		create_sample_file
		car = Car.find(1).first
		car.update_attributes({:year=>"2000",:color=>"yeallow", :brand=>"Fusquinha sem vergonha"})
		
		assert_equal "yeallow",car.color
		assert_equal "yeallow", Car.find(1).first.color
		assert_equal "2000", Car.find(1).first.year
		assert_equal "Fusquinha sem vergonha", Car.find(1).first.brand
		delete_sample
	end

	def test_update_attr_two_attr
		create_sample_file
		car = Car.find(2).first
		car.update_attributes({:color=>"pink", :brand=>"Ferrari"})
		
		assert_equal "pink",car.color
		assert_equal "pink",Car.find(2).first.color
		assert_equal "Ferrari",Car.find(2).first.brand
		delete_sample
	end
end
