require 'test/unit'
require 'active_csv'

class Car < ActiveCSV
	attr_accessor :color, :year, :brand
end

class ActiveCSVTest < Test::Unit::TestCase
	def test_save
		csv = Car.new
		csv.db_file_name = "active_tests.txt"
		csv.attr_file_name = "car_attr.txt"
		csv.save
		assert File.exists? "active_tests.txt"
	end
end
