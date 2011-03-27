require 'require_all'
class FieldsTests < Test::Unit::TestCase
	include TestHelpers
	def test_field_without_set_attr_file
		create_attr_file_for Car
		create_sample_file

		fields_ar = Car.fields('car')

		assert fields_ar.length, 4

		delete_attr_file_for Car
		delete_sample
	end

	def test_field_with_set_attr_file
		create_attr_file_for CarWithSetAttr
		create_sample_file

		fields_ar = CarWithSetAttr.fields('carwithsetattr')

		assert fields_ar.length, 4

		delete_attr_file_for CarWithSetAttr
		delete_sample
	end

end
