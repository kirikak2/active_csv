require 'test/unit'
require 'test_helpers'
require 'car'

class DestroyTests < Test::Unit::TestCase
	include TestHelpers

	def test_destroy_when_exists
		create_sample_file
		car = Car.find(2).first
		car.destroy
		assert_raise(RecordNotFound) do 
			Car.find(2)
		end
		delete_sample
	end

	def test_destroy_sequencially
		create_sample_file
		car = Car.find(2).first
		car.destroy
		car2 = Car.find(3).first
		car2.destroy
		assert_raise(RecordNotFound) do
			Car.find(2)
		end
		assert_raise(RecordNotFound) do
			Car.find(3)
		end
		assert_equal "red",Car.find(1).first.color
		assert_equal "2012",Car.find(4).first.year
		delete_sample
	end

	def test_destroy_non_existing_id
		create_sample_file
		car = Car.new
		car.destroy
		assert_equal 4, Car.all.length
		assert_equal "2", Car.find(2).first.id
		assert_kind_of Car, car.destroy
		delete_sample
	end
end
