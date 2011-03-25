class AttrFile
	@@name = "config/csv_attributes.yml"

	#how can we do this like attr_accessor in instance variables?
	def self.name=(_name)
		@@name = _name
	end

	def self.name
		@@name
	end

	def fields(model_name)
		# The sequency of the attributes is always the same as in the yaml file.
		model_fields = YAML.load_file(AttrFile.name)
		fields = model_fields[model_name].split(', ').insert(0,"id")
		fields
	end
end
