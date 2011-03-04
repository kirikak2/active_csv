require 'test/unit'
require 'active_csv'
require 'test_helpers'

class Car < ActiveCSV
	attr_accessor :color, :year, :brand
end

class Clients < ActiveCSV
	attr_accessor :name, :address
end

class SaveTests < Test::Unit::TestCase
	include TestHelpers

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
end

class AllTests < Test::Unit::TestCase
	include TestHelpers

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
end

class FindTests < Test::Unit::TestCase
	include TestHelpers

	def test_find_by_attr
		create_sample_file
		cars = Car.find(:color=>"red")
		assert_equal "red", cars.first.color
	end

	def test_find_by_attr_missing
		create_sample_file
		assert_raise(RecordNotFound) { cars = Car.find(:color=>"darkblue") }
	end

	def test_find_by_attr_quatity
		create_sample_file
		cars = Car.find(:color=>"red")
		assert_equal 2, cars.length
	end

	def test_find_by_id_2
		create_sample_file
		car = Car.find(2)
		assert_equal "2", car[0].id
	end

	def test_find_by_id_3
		create_sample_file
		car = Car.find(3)
		assert_equal "3", car[0].id
	end

	def test_find_by_id_missing
		create_sample_file
		assert_raise(RecordNotFound) { cars = Car.find(5) }
		delete_sample
	end

	def test_find_by_ids
		create_sample_file
		cars = Car.find(3,4)
		assert_equal "4", cars[1].id
		assert_equal "3", cars[0].id
	end
end
