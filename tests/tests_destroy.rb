require 'require_all'
class DestroyTests < Test::Unit::TestCase
	include TestHelpers

	def setup
		create_attr_file_for Car
	end

	def test_destroy_when_exists
		create_sample_file
		car = Car.find(2)
		car.destroy
		assert_raise RecordNotFound do 
			Car.find(2)
		end
		delete_sample
	end

	def test_destroy_sequencially
		create_sample_file
		car = Car.find(2)
		car.destroy
		car2 = Car.find(3)
		car2.destroy
		assert_raise RecordNotFound do
			Car.find(2)
		end
		assert_raise RecordNotFound do
			Car.find(3)
		end
		assert_equal "red",Car.find(1).color
		assert_equal "2012",Car.find(4).year
		delete_sample
	end

	def test_destroy_obj_without_id
		create_sample_file
		car = Car.new
		assert_kind_of Car, car.destroy
		assert_equal 4, Car.all.length
		assert_equal "2", Car.find(2).id
		delete_sample
	end

	def test_destroy_file_without_id
		create_sample_file
		car = Car.new
		car.id = 5
		assert !car.destroy
		assert_equal 4, Car.all.length
		assert_equal "2", Car.find(2).id
		delete_sample
	end

	def teardown
		delete_attr_file_for Car
	end
end
