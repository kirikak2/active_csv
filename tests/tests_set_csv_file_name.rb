require 'require_all'

class SetCSVFileNameTests < Test::Unit::TestCase
	include TestHelpers

	def test_set_csv_file_name
		create_attr_file_for CarWithSetCSV
		car = CarWithSetCSV.new(:year=>1999, :brand=>"UNO", :color=>"white")
		assert car.save
		assert File.exists? "db/something.csv"
		File.delete "db/something.csv" if File.exists? "db/something.csv"
		delete_attr_file_for CarWithSetCSV
		delete_sample
	end
end
