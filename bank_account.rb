# Learning Goals

# [x] Create and use class methods
# [x] Use a CSV file for loading data - how to test?
#
# Primary Requirements
#
# [x] Update the Account class to be able to manage fields from the CSV file used as input.
# 	 	For example, manually choose the data from the first line of the CSV file
#   	and ensure you can create a new instance of your Account using that data
#
# Add the following class methods to your existing Account class
#
# [x ] self.all - returns a collection (array) of Account instances, r
#     representing all of the Accounts described in the CSV. See below for the CSV file specifications
# [ x] self.find(id) - returns an instance of Account where the value 
#    of the id field in the CSV matches the passed parameter
# [ x] CSV Data File

# Bank::Account

# The data, in order in the CSV, consists of:
# ID - (Fixnum) a unique identifier for that Account
# Balance - (Fixnum) the account balance amount, in cents (i.e., 150 would be $1.50)
# OpenDate - (Datetime) when the account was opened

# () What tests should I write for a module, classess within it, methods?
require 'csv'
raw_acct_data = CSV.read('./support/accounts.csv')





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


#TEST 5
accounts = Bank::Account.all(raw_acct_data)
puts Bank::Account.find('15155', accounts)

#TEST 4
# accounts = Bank::Account.all(raw_acct_data)
# puts Bank::Account.find('1213', accounts)

#TEST 3
# puts Bank::Account.all(raw_acct_data)

# TEST 2
# acct_1 = Bank::Account.new(raw_acct_data[0][0], raw_acct_data[0][1].to_f)
# Your new account id is 1212 and your balance is 1235667.0.


# TEST 1
# puts "Your new account id is #{acct_1.id} and your balance is #{acct_1.balance}."
# returns appropriately is_negative': You must enter a positive balance! (ArgumentError)






# self.all # class method # could this not be a sepreate data sanitizer class
# 	all_accounts_info = []
# 	CSV.foreach("path/to/file.csv") do |row|
# 		all_accounts.push(row)
# 		return all_accounts
# 	end
		
# self.find(id) #class method, expects 2d array, or mebe hash # could this be a seperate search class
# return find
# end	

################################################################
#
# WAVE 2 - above this line
#
################################################################
# Optional:

# Implement the optional requirement from Wave 1
# Add the following class methods to your existing Owner class

# self.all - returns a collection of Owner instances, representing all of the Owners described in the CSV. See below for the CSV file specifications
# self.find(id) - returns an instance of Owner where the value of the id field in the CSV matches the passed parameter
# Bank::Owner
# The data, in order in the CSV, consists of:
# ID - (Fixnum) a unique identifier for that Owner
# Last Name - (String) the owner's last name
# First Name - (String) the owner's first name
# Street Addess - (String) the owner's street address
# City - (String) the owner's city
# State - (String) the owner's state

# To create the relationship between the accounts and the owners 
# use the account_owners CSV file. The data for this file, in order in the CSV, consists of: Account ID - (Fixnum) a unique identifier corresponding to an account Owner ID - (Fixnum) a unique identifier corresponding to an owner

##################
# WAVE 1 testing
##################
# acct_1 = Bank::Account.new(12345678, 100000)

# puts acct_1.see_balance

# puts acct_1.withdraw(500)

# puts acct_1.deposit(200000)

# puts acct_1.see_balance

#############
## WAVE 1
#############

# Learning Goals

# [x] Create a class inside of a module
# [x] Create methods inside the *class* to perform actions
# [x] Learn how Ruby does error handling

# Requirements
##############################################################

# [X] Create a Bank module which will contain your Account class and any future bank account logic.

# [x] Create an Account class which should have the following functionality:

# [x] A new account should be created with an ID and an initial balance
# [x] Should have a withdraw method that accepts a single parameter which represents the amount of money that will be withdrawn. This method should return the updated account balance.
# [x] Should have a deposit method that accepts a single parameter which represents the amount of money that will be deposited. This method should return the updated account balance.
# [x] Should be able to access the current balance of an account at any time.

# Error handling
###############################################################
# A new account cannot be created with initial negative balance - this will raise an ArgumentError (Google this)
	#def transfer_money(amount)
	  #unless amount.is_a?(Number)
	  # raise ArgumentError.new("Only numbers are allowed")
	  # end
  # ... Do the actual work
#end
# The withdraw method does not allow the account to go negative - Will output a warning message and return the original un-modified balance

########## Optional: ################
#
# Create an Owner class which will store information about those who own the Accounts.
# This should have info like name and address and any other identifying information that an account owner would have.
# Add an owner property to each Account to track information about who owns the account.
# The Account can be created with an owner, OR you can create a method that will add the owner after the Account has already been created.
#
########## 
# module Bank
	
# 	class Account

# 		attr_reader :id, :open_date
# 		attr_accessor :balance # this should permit reading and writing

# 		# intial_balance in pennies

# 		def initialize(id, balance)
# 			# ruby dosen't like constants in intialize values, lowercase it
# 			@id = id
# 			@balance = balance
# 			# pretty_initial_balance = (@initial_balance / 100).to_f
# 			is_negative # method to determine if transaction would lead to overdraft
# 		end
# 	end
#   # use row here...

# 	# print debuggin' # raises error as expected if transaction is negative		
# 		def is_negative
# 			unless @balance > 0 
# 				raise ArgumentError.new("You must enter a positive balance!")
# 			end
# 		end

# 		def see_balance
# 			return @balance
# 		end

# 		def withdraw(money)
# 			@balance = @balance - money
# 			is_negative
# 			see_balance
# 		end

# 		def deposit(money)
# 			@balance = @balance + money 
# 			is_negative
# 			see_balance
# 		end
# end
















