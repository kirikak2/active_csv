class ActiveCSV
	require 'csv'
	require 'yaml'

	attr_accessor :db_file_name

	def initialize()
	end

	def fields
		#The sequency of the attrbiutes is alwas the same as the yaml file.
		path = 'models/'
		attributes_file = path+'attributes.yml'
		model_fields = YAML.load_file(attributes_file)
		model_fields #String
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
		new_row = field_values('expenses')
		CSV.open(db_file_name,"wb") do |csv|		
				a.each do |line|
					csv << line
				end
				csv << new_row
		end
	end

=begin notas
	def last
		last_expense = String.new
		if !file_exists?
			create_db_file
		end
		db_file = CSV.read(db_file_name)
		if !db_file.last.nil?
			db_file.last.each do |value|
				last_expense << value
			end
		else
			"nenhum registro encontrado"
		end
	end
=end
end

