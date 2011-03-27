require 'require_all'

class PersistedTests < Test::Unit::TestCase
	include TestHelpers

	def setup
		create_attr_file_for Car
	end

	def test_persisted_is_still_false
		create_sample_file
		car = Car.new({:year=>"1999"})
		assert !car.save #should return false and don't save, once Car validates_presence_of brand
		assert !car.persisted?
		delete_sample
	end
	
	def teardown
		delete_attr_file_for Car
	end
end
