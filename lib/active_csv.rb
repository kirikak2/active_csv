require 'active_csv/errors'
require 'active_csv/class_methods'
require 'active_csv/attr_file'
require 'active_csv/db_file'

class ActiveCSV
	require 'csv'
	require 'yaml'

	extend ClassMethods

	attr_accessor :id, :attr_file, :db_file

	def initialize
		self.attr_file = AttrFile.new("models/attributes.yml")
		self.db_file = DbFile.new(model_name+".txt")
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
		self.id = next_id 
		a = db_file.csv_content
		new_row = field_values
		CSV.open(db_file.name,"wb") do |csv|		
				a.each do |line|
					csv << line
				end
				csv << new_row
		end
	end

	def destroy
		csv_rows = db_file.csv_content
		target_index = ''
		unless self.id == nil
			csv_rows.each_with_index do |row,index|
				if row[0].to_s == self.id.to_s
					target_index = index
				end
			end
			csv_rows.delete_at(target_index)
			CSV.open(db_file.name,"wb") do |csv|		
					csv_rows.each do |line|
						csv << line
					end
			end
		end
		self
	end
end

