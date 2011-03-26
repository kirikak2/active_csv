require 'active_csv/errors'
require 'active_csv/class_methods'
require 'active_csv/db_file'
require 'rubygems'
require 'active_model'

class ActiveCSV
	require 'csv'
	require 'yaml'

	extend ClassMethods
	extend ActiveModel::Naming
	include ActiveModel::Validations
	include ActiveModel::Conversion

	attr_accessor :id, :db_file

	@@attr_file_name = {}

	def self.attr_file_name
		@@attr_file_name[self]
	end

	def self.attr_file_name=(new_name)
		@@attr_file_name[self] = new_name
	end

	#Alias for attr_file_name
	def self.set_attr_file_name(new_name)
		@@attr_file_name[self] = new_name
	end


#----------------------------------------------------------------------------------------------

	def initialize(*attributes)	
		if attributes[0].is_a? Hash || attributes[0].is_a?(ActiveSupport::HashWithIndifferentAccess)
			hash_to_obj(attributes[0])
		end
		self.db_file = DbFile.new("db/"+model_name+".csv")
	end

	def model_name
		self.class.to_s.downcase
	end
	
	def field_values
		attributes = Array.new
		self.class.fields(model_name).each do |field|
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

	def persist_existing
		destroy
		persist_new_obj
	end

	def persist_new_obj
		a = db_file.csv_content
		new_row = field_values
		CSV.open(db_file.name,"wb") do |csv|		
				a.each do |line|
					csv << line
				end
				csv << new_row
		end
	end

	# Also used by form_for in the views on Rails
	def persisted?
    unless self.id.nil?
			true
		else
			false
		end
	end

	def save
		if valid?
			unless persisted?		
				self.id = next_id 
			end
			persist_existing
			return true
		else
			false
		end
	end

	def destroy	
		csv_rows = db_file.csv_content
		target_index = ''
		unless self.id.nil?
			ids = [self.id]
			target_index = ActiveCSV.find_with_ids(ids,csv_rows).first
			unless target_index.nil?
				csv_rows.delete_at(target_index)
				CSV.open(db_file.name,"wb") do |csv|		
					csv_rows.each do |line|
						csv << line
					end
				end
			else
				return false
			end
		end
		self
	end

	def hash_to_obj(hash)
		hash.each do |key, value|
			key = key.to_s
				send("#{key}=", value)
		end
	end

	def update_attributes(hash_attr)
		hash_to_obj(hash_attr)
		if valid?
			persist_existing
			true
		else
			false
		end
	end
end
