class AttrFile
	attr_accessor :name

	def initialize(_name="config/csv_attributes.yml")
		@name = _name
	end
	def fields(model_name)
		# The sequency of the attributes is always the same as in the yaml file.
		model_fields = YAML.load_file(@name)
		fields = model_fields[model_name].split(', ').insert(0,"id")
		fields
	end
end
