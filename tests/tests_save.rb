require 'require_all'
class SaveTests < Test::Unit::TestCase
	include TestHelpers

	def setup
		create_attr_file_for Car
	end

	def test_save_file_exists 
		car = Car.new
		car.year = "1998"
		car.color = "red"
		car.brand = "wolksvagen"
		car.save
		assert File.exists? car.db_file.name
		File.delete(car.db_file.name)
	end

	def test_save_quantity
		create_sample_file
		before = Car.all.length
		car = Car.new
		car.year = "1998"
		car.color = "red"
		car.brand = "wolksvagen"
		assert car.save
		assert_equal before+1, Car.all.length
		delete_sample
	end

	def test_save_again
		create_sample_file
		before = Car.all.length
		car = Car.new
		car.year = "1998"
		car.color = "red"
		car.brand = "wolksvagen"
		assert car.save
		assert car.save
		assert_equal  before+1, Car.all.length
		delete_sample
	end

	def test_dont_save_if_not_valid
		create_sample_file
		before = Car.all.length
		car = Car.new
		car.year = "1998"
		car.color = "red"
		assert !car.save
		assert_equal  before, Car.all.length
		delete_sample
	end

	def teardown
		delete_attr_file_for Car
	end

end
