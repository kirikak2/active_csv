require 'active_csv'

class CarWithSetCSV < ActiveCSV
	attr_accessor :color, :year, :brand
	set_attr_file_name "config/csv_attributes_configurable.yml"
	#set_csv_file_name "db/something.csv"
end
