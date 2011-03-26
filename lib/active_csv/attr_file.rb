class AttrFile
	#@@name = "config/csv_attributes.yml"

	class << self
		attr_accessor :name
	end

	def fields(model_name)
		model_fields = YAML.load_file(AttrFile.name)
		fields = model_fields[model_name].split(', ').insert(0,"id")
		fields
	end
end
