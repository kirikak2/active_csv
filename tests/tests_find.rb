require 'test/unit'
require 'test_helpers'
require 'car'
require 'rubygems'
require 'active_support/hash_with_indifferent_access'

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
		assert_equal "2", car.cid
		delete_sample
	end

	def test_find_by_id_3
		create_sample_file
		car = Car.find(3)
		assert_equal "3", car.cid
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
		assert_equal "4", cars[1].cid
		assert_equal "3", cars[0].cid
		delete_sample
	end

	def test_find_with_active_support_hash
		create_sample_file
		params = ActiveSupport::HashWithIndifferentAccess.new
		params[:id] = "2"
		car = Car.find(params[:id])
		assert_equal "2", car.cid
		delete_sample
	end
end
