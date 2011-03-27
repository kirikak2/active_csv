require 'active_csv'

class Car2 < ActiveCSV
	attr_accessor :color, :year, :brand
	validates_presence_of :brand
	set_attr_file_name "config/csv_attributes_with_other_name.yml"
end
