require 'test/unit'
require 'test_helpers'
require 'car'

class SaveTests < Test::Unit::TestCase
	include TestHelpers

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
		car.save
		assert_equal Car.all.length, before+1
		delete_sample
	end
end
