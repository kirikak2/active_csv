require 'test/unit'
require 'test_helpers'
require 'car'
require 'car_with_set_attr'

class Car2
	set_attr_file_name "config/csv_attributes_with_other_name.yml"
end

class TestsFields < Test::Unit::TestCase
	include TestHelpers
	def test_field_without_set_attr_file
		delete_different_attr_file
		create_attr_file
		create_sample_file

		fields_ar = Car.fields('car')

		assert fields_ar.length, 4

		delete_attr_file
		delete_sample
	end

	def test_field_with_set_attr_file
		delete_attr_file
		create_different_attr_file
		create_sample_file

		fields_ar = Car2.fields('car2')

		assert fields_ar.length, 4

		delete_attr_file
		delete_sample
	end

end
