require 'active_csv'

class CarWithSetCSV < ActiveCSV
	attr_accessor :color, :year, :brand
	set_attr_file_name "tests/config/csv_attributes_configurable.yml"
	set_csv_file_name "tests/db/something.csv"
end
