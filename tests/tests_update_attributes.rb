require 'test/unit'
require 'test_helpers'
require 'car'

class UpdateAttributesTests < Test::Unit::TestCase
	include TestHelpers

	def test_update_attr_1
		create_sample_file
		car = Car.find(1).first
		car.update_attributes({:year=>"2000",:color=>"yeallow", :brand=>"Fusquinha sem vergonha"})
		
		assert_equal "yeallow",car.color
		delete_sample
	end

	def test_update_attr_2
		create_sample_file
		car = Car.find(2).first
		car.update_attributes({:year=>"1500",:color=>"pink", :brand=>"Ferrari"})
		
		assert_equal "pink",car.color
		delete_sample
	end
end
