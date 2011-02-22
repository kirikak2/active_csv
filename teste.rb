require 'ausgaben'
csv = Expense.new
csv.db_file_name = "expenses.txt"
csv.value = "20"
csv.description = "sorvete"
csv.date = "11/22/1984"
csv.mean = "grana"
puts csv.fields
puts csv.field_values('expenses').class
csv.save
