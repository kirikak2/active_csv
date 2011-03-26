require 'active_csv'

class Car < ActiveCSV
	attr_accessor :color, :year, :brand
	validates_presence_of :brand
	set_attr_file_name "config/csv_attributes.yml"
end
