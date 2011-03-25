require 'csv'

module TestHelpers
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
		File.delete("db/car.csv")
	end
	
	def create_attr_file
		content = "car:\n  year,\n  color,\n  brand"
		file = File.new("config/csv_attributes.yml", "wb")
		file.puts content
		file.close
	end

	def delete_attr_file
		File.delete("config/csv_attributes.yml")
	end
end
