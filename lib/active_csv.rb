class RecordNotFound < StandardError
end

class AttrFile

	attr_accessor :name

	def initialize(_name)
		@name = _name
	end
	def fields(model_name)
		# The sequency of the attributes is always the same as in the yaml file.
		model_fields = YAML.load_file(@name)
		model_fields[model_name].split(', ') #Array
	end
end

class DbFile

	attr_accessor :name

	def initialize(_name)
		@name = _name
	end
	def csv_content
		csv_rows = Array.new
		if !file_exists?
			create_db_file
		end
		CSV.read(name).each do |row|
				csv_rows << row
		end
		csv_rows
	end

	def file_exists?
		File.exists?(name)
	end

	def create_db_file
		CSV.open(name,'w')
	end

	def field_values
		ActiveCSV.field_values
	end
end

module ClassMethods

	def all
		objects = Array.new
		db_file = DbFile.new(model_name+".txt")
		attr_array = db_file.csv_content
		objects = ar_to_obj(attr_array)
		objects
	end

	def ar_to_obj(attr_array) # turns array of arrays into object properties. Returns array of objects
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

#------- relacionadas ao find-------
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

	def find_with_attr(args,key,content)
		found_cols = Array.new
		col = attr_column key.to_s
		content.each_with_index do |row, index|
						if row[col] == args[0][key]
							found_cols << index
						end
					end
		found_cols
	end

	def find(*args)
		file = DbFile.new(model_name+".txt")
		content = file.csv_content
		if args[0].respond_to? "integer?"
				found_ids_indexes = find_with_ids(args,content)
				found_rows = find_rows_by_indexes(found_ids_indexes,content)
		else
			args[0].keys.each do |key|
				if check_attr? key.to_s
					found_rows_indexes = find_with_attr(args,key,content)
					found_rows = find_rows_by_indexes(found_rows_indexes,content)
				else
					# raise error
				end
			end
		end
		return ar_to_obj(found_rows)# transforma em objetos

	end

	def model_name
		self.name.to_s.downcase
	end
end

class ActiveCSV

	require 'csv'
	require 'yaml'

	extend ClassMethods

	attr_accessor :id, :attr_file, :db_file

	def initialize
		self.attr_file = AttrFile.new("models/attributes.yml")
		self.db_file = DbFile.new(model_name+".txt")
		self.id = next_id 
	end

	def model_name
		self.class.to_s.downcase
	end
	
	def field_values
		attributes = Array.new
		attr_file.fields(model_name).each do |field|
			 attributes << eval(field)
		end
		attributes #String
	end

	def last_id
		attr_array = self.db_file.csv_content
		unless attr_array.count == 0
			attr_array.last[0]
		else
			0
		end
	end

	def next_id
		last_id.to_i+1
	end

	def save
		a = db_file.csv_content
		new_row = field_values
		CSV.open(db_file.name,"wb") do |csv|		
				a.each do |line|
					csv << line
				end
				csv << new_row
		end
	end

	def delete
		puts next_id
	end
end

