require 'test/unit'
require 'test_helpers'
require 'car'

class FindTests < Test::Unit::TestCase
	include TestHelpers

	def test_find_by_attr
		create_sample_file
		cars = Car.find(:color=>"red")
		assert_equal "red", cars.first.color
		delete_sample
	end

	def test_find_by_attr_missing
		create_sample_file
		assert_raise(RecordNotFound) { cars = Car.find(:color=>"darkblue") }
		delete_sample
	end

	def test_find_by_attr_quatity
		create_sample_file
		cars = Car.find(:color=>"red")
		assert_equal 2, cars.length
		delete_sample
	end

	def test_find_by_id_2
		create_sample_file
		car = Car.find(2)
		assert_equal "2", car.id
		delete_sample
	end

	def test_find_by_id_3
		create_sample_file
		car = Car.find(3)
		assert_equal "3", car.id
		delete_sample
	end

	def test_find_by_id_missing
		create_sample_file
		assert_raise(RecordNotFound) { cars = Car.find(5) }
		delete_sample
	end

	def test_find_by_ids
		create_sample_file
		cars = Car.find(3,4)
		assert_equal "4", cars[1].id
		assert_equal "3", cars[0].id
		delete_sample
	end
end
