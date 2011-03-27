require 'require_all'



class SetAttrFileNameTests < Test::Unit::TestCase
	include TestHelpers
	
	def test_set_attr_file_name
		create_attr_file_for CarWithSetAttr
		before = CarWithSetAttr.all.length
		car = CarWithSetAttr.new(:year=>1999)
		car.brand = "WV"
		car.color = "red again"
		assert car.save
		assert_equal before+1, CarWithSetAttr.all.length
		delete_attr_file_for CarWithSetAttr
		delete_sample
	end

end
