################################################################
#
# WAVE 2 - above this line
#
################################################################
require 'csv'

module Bank	
	class Account
	
	attr_reader :id, :open_date # read only as these should be immutable
	attr_accessor :balance # this should permit reading and writing
	
	# intial_balance in pennies
	
		def initialize(id, balance, open_date)
		# ruby dosen't like constants in intialize values, lowercase it
			@id = id
			@balance = balance
			@open_date = open_date
			# pretty_initial_balance = (@initial_balance / 100).to_f
			is_negative # method to determine if transaction would lead to overdraft
		end
		
		# print debuggin' # raises error as expected if transaction is negative		
		def is_negative
			unless @balance > 0 
				raise ArgumentError.new("You must enter a positive balance!")
			end
		end
		
		def see_balance
			return @balance
		end
		
		def withdraw(money)
			@balance = @balance - money
			is_negative
			see_balance
		end
		
		def deposit(money)
			@balance = @balance + money 
			is_negative
			see_balance
		end
		
		def self.all(csv_data)
			accounts_all = []
			csv_data.each do |line|
				#puts line werks as expected
				line_acct_id = line[0] 
				#puts line_acct_id
				current_balance = line[1]
				# puts current_balance
				open_date = line[2]
				#puts open_date
				new_account = Bank::Account.new(line_acct_id, current_balance.to_f, open_date)
				accounts_all.push(new_account)
			end
			return  accounts_all
		#return csv_data
		end
		
		#FROM Austin, this method should take an array of accounts as a parameter, in addition the ID
		def self.find(id, accounts)
			accounts.each do |account|
				if id == account.id
					return account
				end
		end
		return nil #"Account not found." # generally bad for fxns to return two dif kinds of data, here you may get acct or string. Nil might be better.
		end
	end
end
#>>>>>>> 4bfbfaed41b8c1ee3bc70c8a3ddb637dbc9e147b


# TEST 5
# accounts = Bank::Account.all(raw_acct_data)
# puts Bank::Account.find('15155', accounts)

# TEST 4
# accounts = Bank::Account.all(raw_acct_data)
# puts Bank::Account.find('1213', accounts)

# TEST 3
# puts Bank::Account.all(raw_acct_data)

# TEST 2
# acct_1 = Bank::Account.new(raw_acct_data[0][0], raw_acct_data[0][1].to_f)
# Your new account id is 1212 and your balance is 1235667.0.


# TEST 1
# puts "Your new account id is #{acct_1.id} and your balance is #{acct_1.balance}."
# returns appropriately is_negative': You must enter a positive balance! (ArgumentError)






self.all # class method # could this not be a sepreate data sanitizer class
	all_accounts_info = []
	CSV.foreach("path/to/file.csv") do |row|
		all_accounts.push(row)
		return all_accounts
	end
		
self.find(id) #class method, expects 2d array, or mebe hash # could this be a seperate search class
return find
end	