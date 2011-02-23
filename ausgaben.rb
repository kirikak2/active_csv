require 'active_csv'

class Expense < ActiveCSV
	
	attr_accessor :value, :date, :description, :mean

end

########### Execução ##############
expense = Expense.new()
expense.db_file_name = "expenses.txt"
command = ARGV[0]

if command == "add"
	command, value, date, description, mean = ARGV
	expense.value = value
	expense.date = date
	expense.description = description
	expense.mean = mean

	expense.save
end
if command == "last"
	expenses = Expense.all
end

puts expenses[1].description
