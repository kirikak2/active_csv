require 'test/unit'
require 'active_csv'

class Car < ActiveCSV
	attr_accessor :color, :year, :brand
end

class ActiveCSVTest < Test::Unit::TestCase
	def test_save_file_exists
		car = Car.new
		car.attr_file_name = "attributes.yml"
		car.year = "1998"
		car.color = "red"
		car.brand = "wolksvagen"
		car.save
		puts car.inspect
		assert File.exists? car.db_file_name
		File.delete(car.db_file_name)
	end

	def test_all
		cars = Car.all
puts 		cars.inspect
		assert_equal(3,cars.length)
	end
end
