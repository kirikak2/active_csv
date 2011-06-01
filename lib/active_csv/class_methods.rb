module ClassMethods

	def set_csv_file_name
		
	end

	def fields(model_name)
		attribute_file = attr_file_name
		if attribute_file.nil?
			attribute_file = "tests/config/csv_attributes.yml"
		end
		model_fields = YAML.load_file(attribute_file)
		fields = model_fields[model_name].split(', ').insert(0,"id")
		fields
	end

	def all
		objects = Array.new
		db_file = DbFile.new(csv_file_name)####
		attr_array = db_file.csv_content
		objects = ar_to_obj(attr_array)
		objects
	end


  # turns array of arrays into array of objects
	def ar_to_obj(attr_array)
		objects = Array.new
		attr_array.each do |row|
			new_object = eval(self.name).new
			fields_ar = fields(model_name_)
			fields_ar.each_index do |index|
				new_object.send("#{fields_ar[index]}=",row[index])
			end
			objects << new_object
		end
		objects
	end

#------- FIND related -----------

	def check_attr?(attribute)
		fields(model_name_).include? attribute
	end

	def attr_column(attribute)
		fields(model_name_).index attribute
	end

	def find_rows_by_indexes(indexes,content)
		found_rows = Array.new
		case indexes.size
		when 0
				raise RecordNotFound, "Couldn't find the especified ID"
		else
			indexes.each do |found|
				found_rows << content[found]
			end
		end
		found_rows
	end

	def find_with_ids(ids,content)
		found_ids = Array.new
		content.each_with_index do |row, index|
				ids.each do |id|
					if row[0] == id.to_s
						found_ids << index
					end
				end
		end
		found_ids
	end

	def find_with_attr(attribute,value,content)
		found_cols = Array.new
		col = attr_column attribute.to_s
		content.each_with_index do |row, index|
						if row[col] == value
							found_cols << index
						end
					end
		found_cols #indexes
	end

	def find(*args)
		file = DbFile.new(csv_file_name)###
		content = file.csv_content
		if args[0].respond_to? "to_i"
				ids = Array.new
				args.each do |el|
								ids << el.to_i
				end
				found_ids_indexes = find_with_ids(ids,content)
				found_rows = find_rows_by_indexes(found_ids_indexes,content)
		else
			args[0].keys.each do |key|
				if check_attr? key.to_s
					found_rows_indexes = find_with_attr(key,args[0][key],content)
					found_rows = find_rows_by_indexes(found_rows_indexes,content)
				else
					# raise error
				end
			end
		end
		found = ar_to_obj(found_rows)
		if args.length == 1 && args[0].respond_to?("to_i")
			return found.first
		else
			return found 
		end
	end

#CAREFULL HERE
#to not use the method with the same name in ActiveModel::Naming
	def model_name_
		self.name.to_s.downcase
	end
end
