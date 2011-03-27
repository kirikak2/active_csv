require 'require_all'

class AllTests < Test::Unit::TestCase
	include TestHelpers

	def setup
		create_attr_file
		delete_different_attr_file
	end

	def test_all
		create_sample_file
		cars = Car.all
		assert_equal(4,cars.length)
		delete_sample
	end

	def test_kind_of_objects_from_all
		create_sample_file
		cars = Car.all
		assert_instance_of Car, cars.first
		delete_sample
	end

	def test_all_empty
		cars = Car.all
		assert_equal(0,cars.length)
	end

	def teardown
		delete_attr_file
	end
end
