require 'test/unit'
require 'active_csv'

class Car < ActiveCSV
	attr_accessor :color, :year, :brand
end

class ActiveCSVTest < Test::Unit::TestCase
	def create_sample_file
		content = [["1","10,00", "sorvete"," 11/11/11", "dinheiro"],
							["2","4,45"," barbie"," 11/11/11", "MasterCard"],
							["3","10,00", "sorvete"," 11/11/11", "dinheiro"]]
		CSV.open("car.txt","wb") do |csv|
			content.each do |line|
				csv << line
			end
		end
	end

	def delete_sample
		File.delete("car.txt")
	end

# SAVE
	def test_save_file_exists
		car = Car.new
		car.attr_file_name = "attributes.yml"
		car.year = "1998"
		car.color = "red"
		car.brand = "wolksvagen"
		car.save
		assert File.exists? car.db_file_name
		File.delete(car.db_file_name)
	end

# ALL
	def test_all
		create_sample_file
		cars = Car.all
		puts cars.inspect
		assert_equal(3,cars.length)
		delete_sample
	end

	def test_all_empty
		cars = Car.all
		assert_equal(0,cars.length)
	end

# FIND


end
