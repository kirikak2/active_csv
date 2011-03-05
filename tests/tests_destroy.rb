require 'test/unit'
require 'test_helpers'
require 'car'

class SaveTests < Test::Unit::TestCase
	include TestHelpers

	def test_destroy_when_exists
		create_sample_file
		car = Car.find(2).first
		car.destroy
		assert_raise(RecordNotFound) do 
			Car.find(2)
		end
		delete_sample
	end
end
