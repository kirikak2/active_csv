require 'require_all'

class SetCSVFileNameTests < Test::Unit::TestCase
	include TestHelpers

	def test_set_csv_file_name_saving
		create_attr_file_for CarWithSetCSV
		car = CarWithSetCSV.new(:year=>1999, :brand=>"UNO", :color=>"white")
		assert car.save
		assert File.exists? "tests/db/something.csv"
		File.delete "tests/db/something.csv" if File.exists? "tests/db/something.csv"
		delete_attr_file_for CarWithSetCSV
		delete_sample
	end

	def test_set_csv_file_by_calling_attr
		create_attr_file_for CarWithSetCSV
		assert CarWithSetCSV.csv_file_name, "tests/db/something.csv"
		delete_attr_file_for CarWithSetCSV
	end
end
