require 'test/unit'
require 'test_helpers'
require 'car'

class SaveTests < Test::Unit::TestCase
	include TestHelpers

	def setup
		create_attr_file unless File.exists? "config/csv_attributes.yml"
	end

	def test_persisted_is_still_false
		create_sample_file
		car = Car.new({:year=>"1999"})
		assert !car.save #should return false and don't save, once Car validates_presence_of brand
		assert !car.persisted?
		delete_sample
	end
end
