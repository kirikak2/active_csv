require '../active_csv'

class Car < ActiveCSV
	attr_accessor :color, :year, :brand
end
