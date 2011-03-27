require 'csv'

module TestHelpers

#-------DB File ----------------------------------
	def create_sample_file 
		content = [["1","1997", "red","Fiat"],
							["2","1992", "red","Fiat"],
							["3","1964","yellow","Fusca"],
							["4","2012", "black","Citroën"]]
		CSV.open("db/car.csv","wb") do |csv|
			content.each do |line|
				csv << line
			end
		end
	end

	def delete_sample
		if File.exists? "db/car.csv"
			File.delete("db/car.csv")
		end
	end

	def delete_all_db_files
		# maybe a rake task?		
	end


#---------Attr File------------------------------
	def create_attr_file
		unless File.exists? "config/csv_attributes.yml"
			content = "car:\n  year,\n  color,\n  brand"
			file = File.new("config/csv_attributes.yml", "wb")
			file.puts content
			file.close
		end
	end

	def delete_attr_file
		if File.exists? "config/csv_attributes.yml"
			File.delete("config/csv_attributes.yml")
		end
	end

	def create_attr_file_for(model_name)
		unless File.exists? "config/csv_attributes_configurable.yml"
			content = "#{model_name}:\n  year,\n  color,\n  brand"
			file = File.new("config/csv_attributes_configurable.yml", "wb")
			file.puts content
			file.close
		end
	end

	def delete_attr_file_for(model_name)
		if File.exists? "config/csv_attributes_configurable.yml"
			File.delete "config/csv_attributes_configurable.yml"
		end
	end

	def create_different_attr_file
		unless File.exists? "config/csv_attributes_with_other_name.yml"
			content = "carwithsetattr:\n  year,\n  color,\n  brand"
			file = File.new("config/csv_attributes_with_other_name.yml", "wb")
			file.puts content
			file.close
		end
	end

	def delete_different_attr_file
		if File.exists? "config/csv_attributes_with_other_name.yml"
			File.delete("config/csv_attributes_with_other_name.yml")
		end
	end
end
