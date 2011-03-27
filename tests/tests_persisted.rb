require 'require_all'

class SaveTests < Test::Unit::TestCase
	include TestHelpers

	def setup
		create_attr_file
		delete_different_attr_file
	end

	def test_persisted_is_still_false
		create_sample_file
		car = Car.new({:year=>"1999"})
		assert !car.save #should return false and don't save, once Car validates_presence_of brand
		assert !car.persisted?
		delete_sample
	end
end
