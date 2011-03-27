require 'require_all'
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

		fields_ar = CarWithSetAttr.fields('carwithsetattr')

		assert fields_ar.length, 4

		delete_different_attr_file
		delete_sample
	end

end
