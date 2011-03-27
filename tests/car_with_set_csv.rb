require 'active_csv'

class CarWithSetCSV < ActiveCSV
	attr_accessor :color, :year, :brand
	set_csv_file_name "db/something.csv"
end
