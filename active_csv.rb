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
		db_file = DbFile.new("car"+".txt")
		attr_array = db_file.csv_content
		objects = ar_to_obj(attr_array)
		objects
	end

	def ar_to_obj(attr_array) # turns array of arrays into object properties. Returns array of objects
		objects = Array.new
		new_object = eval(self.name).new
		attr_array.each do |row|
				fields_ar = new_object.attr_file.fields(model_name)
				fields_ar.each_index do |index|
					eval("new_object."+fields_ar[index]+" = row[index]") #new_object.fields_ar[0] = row[0] and so on...
				end
				objects << new_object
		end
		objects
	end

# relacionadas ao find
	def check_attr?(attribute)
		attr_file = AttrFile.new("models/attributes.yml")	
		attr_file.fields(model_name).include? attribute
	end

	def attr_column(attribute)
		object  = eval(self.name).new
		object.attr_file.fields(model_name).index attribute
	end

	def find(*args)
		found_rows = Array.new
		if args.length == 1 && (args[0].respond_to? "integer?")
				file = DbFile.new("car.txt")
				content = file.csv_content
				found_ids = Array.new
				content.each_with_index do |row, index|
						if row[0] == args[0].to_s	#achar a palavra de busca dentro do arquivo
							found_ids << index
						end
				end
				found_ids.each do |found|
					found_rows << content[found]
				end
		else
			args[0].keys.each do |key|
				if check_attr? key.to_s
					file = DbFile.new("car.txt")
					col = attr_column key.to_s # descobrir qual é a posição deste atributo
					content = file.csv_content # pegar o conteudo do arquivo
					found_cols = Array.new
					content.each_with_index do |row, index|
						if row[col] == args[0][key]		#achar a palavra de busca dentro do arquivo
							found_cols << index
						end
					end
				
					found_cols.each do |found|	#recuperar o array completo para cada apalvra encontrada e retornar
						found_rows << content[found]
					end
				else
					# raise error
				end
			end
			"opa"
		end

		return ar_to_obj(found_rows)# transforma em objeto

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
		self.db_file = DbFile.new("car"+".txt")
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

