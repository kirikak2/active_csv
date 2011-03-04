require 'csv'

module TestHelpers
	def create_sample_file 
		content = [["1","1997", "red","Fiat"],
							["2","1992", "red","Fiat"],
							["3","1964","yellow","Fusca"],
							["4","2012", "black","Citroën"]]
		CSV.open("car.txt","wb") do |csv|
			content.each do |line|
				csv << line
			end
		end
	end

	def delete_sample
		File.delete("car.txt")
	end
end
