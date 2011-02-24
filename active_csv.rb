class ActiveCSV
	require 'csv'
	require 'yaml'

	attr_accessor :db_file_name

	def initialize()
	end

	def self.all
		objects = Array.new
		CSV.read('expenses.txt').each do |row|
				new_object = eval(self.name).new
				fields_ar = new_object.fields
				fields_ar.each_index do |index|
					eval("new_object."+fields_ar[index]+" = row[index]") #new_object.fields_ar[0] = row[0] and so on...
				end
				objects << new_object
		end
		objects
	end

	def self.check_attr?(attribute)
		object  = eval(self.name).new
		object.fields.include? attribute
	end

	def self.attr_column(attribute)
		object  = eval(self.name).new
		object.fields.index attribute
	end

	def self.find(*args)
		args[0].keys.each do |key|
			if check_attr? key.to_s
				col = attr_column key.to_s #descobrir qual é a posição deste atributo
				object =  eval(self.name).new
				object.db_file_name = "expenses.txt"
				content = object.csv_content #pegar o conteudo do arquivo
				content.each do |row|
					puts row[col]
				end
				#achar a palavra de busca dentro do arquivo
				#recuperar o array completo para cada apalvra encontrada e retornar
			else
				#raise error
			end
		end
	end

	def model_name
		self.class.to_s.downcase
	end

	def fields
		#The sequency of the attributes is always the same as in the yaml file.
		path = 'models/'
		attributes_file = path+'attributes.yml'
		model_fields = YAML.load_file(attributes_file)
		model_fields[model_name].split(', ') #Array
	end

	def field_values(model)
		attributes = Array.new
		splitted_fields=fields[model].split(', ')
		splitted_fields.each do |field|
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

	def save
		a = csv_content
		new_row = field_values(model_name)
		CSV.open(db_file_name,"wb") do |csv|		
				a.each do |line|
					csv << line
				end
				csv << new_row
		end
	end
end

