class ActiveCSV
	require 'csv'
	require 'yaml'

	attr_accessor :db_file_name, :id, :attr_file_name

	def initialize(file_name)
		self.db_file_name = file_name
		self.id = next_id 
	end

	def self.all
		objects = Array.new
		new_object = eval(self.name).new
		new_object.db_file_name = "expenses.txt" # HARD-CODE
		attr_array = new_object.csv_content
		objects = ar_to_obj(attr_array)
		objects
	end

	def self.ar_to_obj(attr_array) # turns array of arrays into object properties. Returns array of objects
		objects = Array.new
		new_object = eval(self.name).new
		attr_array.each do |row|
				fields_ar = new_object.fields
				fields_ar.each_index do |index|
					eval("new_object."+fields_ar[index]+" = row[index]") #new_object.fields_ar[0] = row[0] and so on...
				end
				objects << new_object
		end
		objects
	end

# relacionadas ao find
	def self.check_attr?(attribute)
		object  = eval(self.name).new
		object.fields.include? attribute
	end

	def self.attr_column(attribute)
		object  = eval(self.name).new
		object.fields.index attribute
	end

	def self.find(*args)
		found_rows = Array.new
		args[0].keys.each do |key|
			if check_attr? key.to_s
				col = attr_column key.to_s # descobrir qual é a posição deste atributo
				object =  eval(self.name).new
				object.db_file_name = "expenses.txt" #HARD-CODE
				content = object.csv_content #pegar o conteudo do arquivo
				found_cols = Array.new
				content.each_with_index do |row, index|
					if row[col] == args[0][key]				#achar a palavra de busca dentro do arquivo
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

		return ar_to_obj(found_rows)# transforma em objeto

	end

	def model_name
		self.class.to_s.downcase
	end
	
	def fields
		# The sequency of the attributes is always the same as in the yaml file.
		model_fields = YAML.load_file(attr_file_name)
		model_fields[model_name].split(', ') #Array
	end

	def field_values(model)
		attributes = Array.new
		fields.each do |field|
			 attributes << eval(field)
		end
		attributes #String
	end

	def file_exists?
		File.exists?(db_file_name)
	end

	def create_db_file
		CSV.open(db_file_name,'w')
	end

	def csv_content
		csv_rows = Array.new
		if !file_exists?
			create_db_file
		end
		CSV.read(db_file_name).each do |row|
				csv_rows << row
		end
		csv_rows
	end

	def last_id
		attr_array = csv_content
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
		a = csv_content
		puts csv_content
		new_row = field_values(model_name)
		CSV.open(db_file_name,"wb") do |csv|		
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

