class DbFile
	attr_accessor :name

	def initialize(_name)
		if _name.nil?
			@name = 'tests/db/'+'car'+'.csv'
		else
			@name = _name
		end
	end

	def name
		@name
	end

	def csv_content
		csv_rows = Array.new
		if !file_exists?
			create_db_file
		end
		CSV.read(name).each do |row|
				csv_rows << row
		end
		csv_rows
	end

	def file_exists?
		File.exists?(name)
	end

	def create_db_file
		CSV.open(name,'w')
	end
end
