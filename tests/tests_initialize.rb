require 'test/unit'
require 'test_helpers'
require 'car'

class InitializeTests < Test::Unit::TestCase
	include TestHelpers

	def test_initialize_with_attr_hash
		car = Car.new(:color=>"blues")
		assert_equal "blues",car.color
	end

	def test_initialize_with_attr_hash
		car = Car.new(:color=>"green")
		assert_equal "green",car.color
	end

	def test_initialize_with_attr_hash
		car = Car.new(:color=>"darkblue", :year=>"1999",:brand=>"Renault")
		assert_equal "darkblue",car.color
		assert_equal "Renault",car.brand
		assert_equal "1999",car.year
	end
end
