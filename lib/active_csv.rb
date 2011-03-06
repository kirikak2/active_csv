require 'active_csv/errors'
require 'active_csv/class_methods'
require 'active_csv/attr_file'
require 'active_csv/db_file'
require 'rubygems'
require 'active_model/naming'

class ActiveCSV
	require 'csv'
	require 'yaml'

	extend ClassMethods
	extend ActiveModel::Naming


	attr_accessor :cid, :attr_file, :db_file

	def initialize(*attributes)	
		if attributes[0].is_a? Hash || attributes[0].is_a?(ActiveSupport::HashWithIndifferentAccess)
			hash_to_obj(attributes[0])
		end
		self.attr_file = AttrFile.new("config/csv_attributes.yml")
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

	def last_cid
		attr_array = self.db_file.csv_content
		unless attr_array.count == 0
			attr_array.last[0]
		else
			0
		end
	end

	def next_cid
		last_cid.to_i+1
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

	def save
		if self.cid.nil?		
			self.cid = next_cid 
		end
		persist_existing
		true
	end

	def destroy	
		csv_rows = db_file.csv_content
		target_index = ''
		unless self.cid.nil?
			cids = [self.cid]
			target_index = ActiveCSV.find_with_ids(cids,csv_rows).first
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
			eval("if hash[:"+key+"]; self."+key+" = hash[:"+key+"]; else; self."+key+" = hash[\""+key+"\"];end;") #this logic should be moved from here
		end
	end

	def update_attributes(hash_attr)
		hash_to_obj(hash_attr)
		persist_existing
		true
	end
end

