require 'test/unit'
require 'active_csv'

class Car < ActiveCSV
	attr_accessor :color, :year, :brand
end

class ActiveCSVTest < Test::Unit::TestCase
	def test_save_file_exists
		csv = Car.new("active_tests.txt")
		csv.attr_file_name = "car_attr.yml"
		csv.year = "1998"
		csv.color = "red"
		csv.brand = "wolksvagen"
		csv.save
		puts csv.inspect
		assert File.exists? csv.db_file_name
		File.delete(csv.db_file_name)
	end

	def test_save_number_of _entries
		
	end
end
