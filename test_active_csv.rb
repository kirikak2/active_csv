require 'test/unit'
require 'active_csv'

class Car < ActiveCSV
	attr_accessor :color, :year, :brand
end

class ActiveCSVTest < Test::Unit::TestCase

############ SAVE method #################
	def test_save_file_exists 
		car = Car.new
		car.year = "1998"
		car.color = "red"
		car.brand = "wolksvagen"
		car.save
		assert File.exists? car.db_file.name
		File.delete(car.db_file.name)
	end

	def test_save_quantity
		create_sample_file
		before = Car.all.length
		car = Car.new
		car.year = "1998"
		car.color = "red"
		car.brand = "wolksvagen"
		car.save
		assert_equal Car.all.length, before+1
		delete_sample
	end

############### ALL method ####################
	def test_all
		create_sample_file
		cars = Car.all
		assert_equal(4,cars.length)
		delete_sample
	end

	def test_kind_of_objects_from_all
		create_sample_file
		cars = Car.all
		assert_instance_of Car, cars.first
		delete_sample
	end

	def test_all_empty
		cars = Car.all
		assert_equal(0,cars.length)
	end

############### FIND method ###################
	def test_find_by_attr
		create_sample_file
		cars = Car.find(:color=>"red")
		assert_equal cars.first.color, "red"
	end

	def test_find_by_attr_quatity
		create_sample_file
		cars = Car.find(:color=>"red")
		assert_equal cars.length,2
	end

	def test_find_by_id
		create_sample_file
		cars = Car.find(2)
		assert_equal cars[0].id, 2
	end

#---------helper methods-----------------
	def create_sample_file 
		content = [["1","1997", "red","Fiat"],
							["2","1992", "red","Fiat"],
							["3","1964","yellow","Fusca"],
							["4","2012", "black","Citroën"]]
		CSV.open("car.txt","wb") do |csv|
			content.each do |line|
				csv << line
			end
		end
	end

	def delete_sample
		File.delete("car.txt")
	end
end
