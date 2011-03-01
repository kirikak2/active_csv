require 'active_csv'

class Expense < ActiveCSV
	
	attr_accessor :value, :date, :description, :mean

end

########### Execução ##############
expense = Expense.new
command = ARGV[0]

if command == "add"
	command, value, description,date, mean = ARGV
	expense.value = value
	expense.date = date
	expense.description = description
	expense.mean = mean
	expense.attr_file_name = "models/attributes.yml"
	expense.save
	puts expense.inspect
end
if command == "last"
	expenses = Expense.all
	puts expenses[1].inspect
end

if command == "find"
	word = ARGV[1]
	expenses = Expense.find(:description=>word)
	puts expenses.inspect
end
if command == "delete_last"
	expenses = Expense.all
	expenses.last.db_file_name= "expenses.txt"
	expenses.last.delete
end

