require 'active_csv'

class Car2 < ActiveCSV
	attr_accessor :color, :year, :brand
	validates_presence_of :brand
end
