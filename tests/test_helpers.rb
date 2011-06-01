require 'csv'

module TestHelpers

#-------DB File ----------------------------------
	def create_sample_file 
		content = [["1","1997", "red","Fiat"],
							["2","1992", "red","Fiat"],
							["3","1964","yellow","Fusca"],
							["4","2012", "black","Citroën"]]
		CSV.open("tests/db/car.csv","wb") do |csv|
			content.each do |line|
				csv << line
			end
		end
	end

	def delete_sample
		if File.exists? "tests/db/car.csv"
			File.delete("tests/db/car.csv")
		end
	end

	def delete_all_db_files
		# maybe a rake task?		
	end


#---------Attr File------------------------------

	def create_attr_file_for(model_name)
		if model_name.attr_file_name.nil?
			file_name = "tests/config/csv_attributes.yml"
		else
			file_name = model_name.attr_file_name
		end
		unless File.exists? "#{file_name}"
			content = "#{model_name.to_s.downcase}:\n  year,\n  color,\n  brand"
			file = File.new("#{file_name}", "wb")
			file.puts content
			file.close
		end
	end

	def delete_attr_file_for(model_name)
		if model_name.attr_file_name.nil?
			file_name = "tests/config/csv_attributes.yml"
		else
			file_name = model_name.attr_file_name
		end
		if File.exists? "#{file_name}"
			File.delete "#{file_name}"
		end
	end

#-------------------------------------------------------

end
