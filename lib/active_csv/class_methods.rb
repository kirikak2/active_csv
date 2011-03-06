module ClassMethods
	def all
		objects = Array.new
		db_file = DbFile.new(model_name+".txt")
		attr_array = db_file.csv_content
		objects = ar_to_obj(attr_array)
		objects
	end

	def ar_to_obj(attr_array) # turns array of arrays into array of objects
		objects = Array.new
		attr_array.each do |row|
			new_object = eval(self.name).new
			fields_ar = new_object.attr_file.fields(model_name)
			fields_ar.each_index do |index|
				eval("new_object."+fields_ar[index]+" = row[index]") #new_object.fields_ar[0] = row[0] and so on...
			end
			objects << new_object
		end
		objects
	end

#------- relacionadas ao find-----------
	def check_attr?(attribute)
		attr_file = AttrFile.new("models/attributes.yml")	
		attr_file.fields(model_name).include? attribute
	end

	def attr_column(attribute)
		object  = eval(self.name).new
		object.attr_file.fields(model_name).index attribute
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
		file = DbFile.new(model_name+".txt")
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

	def model_name
		self.name.to_s.downcase
	end
end
