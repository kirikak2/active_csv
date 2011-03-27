require 'test/unit'
require 'test_helpers'
require 'car_with_set_csv'
require 'rubygems'
require 'active_support/hash_with_indifferent_access'



class SetCSVFileNameTests < Test::Unit::TestCase
	include TestHelpers

	def test_set_csv_file_name
		delete_something_db_file
		create_attr_file_for :carwithsetcsv
		car = CarWithSetCSV.new(:year=>1999, :brand=>"UNO", :color=>"white")
		assert car.save
		assert File.exists? "db/something.csv"
#		delete_attr_file
#		delete_sample
	end
end
