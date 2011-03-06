require 'test/unit'
require 'test_helpers'
require 'car'

class UpdateAttributesTests < Test::Unit::TestCase
	include TestHelpers

	def test_update_attr_three_attr
		create_sample_file
		car = Car.find(1)
		car.update_attributes({:year=>"2000",:color=>"yeallow", :brand=>"Fusquinha sem vergonha"})
		
		assert_equal "yeallow",car.color
		assert_equal "yeallow", Car.find(1).color
		assert_equal "2000", Car.find(1).year
		assert_equal "Fusquinha sem vergonha", Car.find(1).brand
		delete_sample
	end

	def test_update_attr_two_attr
		create_sample_file
		car = Car.find(2)
		car.update_attributes({:color=>"pink", :brand=>"Ferrari"})
		
		assert_equal "pink",car.color
		assert_equal "pink",Car.find(2).color
		assert_equal "Ferrari",Car.find(2).brand
		delete_sample
	end

	def test_update_attr_keeping_other_attr
		create_sample_file
		car = Car.find(2)
		car.update_attributes({:brand=>"Gol bolinha"})
		
		assert_equal "red",car.color
		assert_equal "Gol bolinha",Car.find(2).brand
		delete_sample
	end
end
