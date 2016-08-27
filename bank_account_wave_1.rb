#############
## WAVE 1
#############

# Learning Goals
##############################################################
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
# [x] A new account cannot be created with initial negative balance - this will raise an ArgumentError (Google this)
# [x] The withdraw method does not allow the account to go negative - Will output a warning message and return the original un-modified balance

module Bank
	
	class Account

		attr_reader :id, :open_date
		attr_accessor :balance # this should permit reading and writing

		# intial_balance in pennies

		def initialize(id, balance)
			# ruby dosen't like constants in intialize values, lowercase it
			@id = id
			@balance = balance
			# pretty_initial_balance = (@initial_balance / 100).to_f
			is_negative # method to determine if transaction would lead to overdraft
		end
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
end
