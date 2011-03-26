require 'test/unit'
require 'test_helpers'
require 'car'
require 'rubygems'
require 'active_support/hash_with_indifferent_access'

class InitializeTests < Test::Unit::TestCase
	include TestHelpers

	def setup
		create_attr_file
		delete_different_attr_file
	end

	def test_initialize_with_attr_hash
		car = Car.new(:color=>"blues")
		assert_equal "blues",car.color
	end

	def test_initialize_with_attr_hash
		car = Car.new(:color=>"green")
		assert_equal "green",car.color
	end

	def test_initialize_with_attr_symbol
		car = Car.new(:color=>"darkblue", :year=>"1999",:brand=>"Renault")
		assert_equal "darkblue",car.color
		assert_equal "Renault",car.brand
		assert_equal "1999",car.year
	end

	def test_initialize_with_attr_strings
		car = Car.new("color"=>"darkblue", "year"=>"1999","brand"=>"Renault")
		assert car.save
		assert_equal "darkblue",car.color
		assert_equal "Renault",car.brand
		assert_equal "1999",car.year
	end
	
	def test_initialize_with_active_suport_hash
		params = ActiveSupport::HashWithIndifferentAccess.new
		params[:car] = {:color=>"blue", :year=>"1999", :brand=>"Gol"}
		car = Car.new(params[:car])
		assert_equal "Gol", car.brand
		assert_equal "blue", car.color
		assert_equal "1999", car.year
	end
end
