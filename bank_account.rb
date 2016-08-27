#BANK ACCOUNT WAVE 3 
#Create a SavingsAccount class which should inherit behavior from the Account class. It should include the following updated functionality:
# * Use inheritance to share some behavior across classes
# * Enhance functionality built in Wave 1
# 
# [x] The initial balance cannot be less than $10. If it is, this will raise an ArgumentError
# [x ] Updated withdrawal functionality:
# 	(x) Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance.
# 	(x) Does not allow the account to go below the $10 minimum balance - Will output a warning message and return the original un-modified balance


# [x] add_interest(rate): Calculate the interest on the balance and add the interest to the balance. Return the interest that was calculated and added to the balance (not the updated balance).
# [x] Input rate is assumed to be a percentage (i.e. 0.25).
# *** The formula for calculating interest is balance * rate/100
# *** Example: If the interest rate is 0.25% and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.
# [x] Create a CheckingAccount class which should inherit behavior from the Account class. It should include the following updated functionality:

# [x] Updated withdrawal functionality:
# 	(x) Each **cash** withdrawal 'transaction' incurs a fee of $1 that is taken out of the balance. Returns the updated account balance.
# 	(x) Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
# 	(x) withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
#   (x) Allows the account to go into overdraft up to -$10 but not any lower
#   (x) The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee
#[x] reset_checks: Resets the number of checks used to zero
# { } build a helper method for fee that takes two parameters

module Bank
	
	class Account

		attr_reader :id, :open_date
		attr_accessor :balance # this should permit reading and writing

		# intial_balance in pennies

		def initialize(id, balance, open_date)
			# ruby dosen't like constants in intialize values, lowercase it
			@id = id
			@balance = balance
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

		# this is Accounts class methods
		def withdraw(money)
			@balance = @balance - money
			is_to_low
			return see_balance
		end

		def deposit(money)
			@balance = @balance + money 
			is_to_low
			return see_balance
		end
	end


	class SavingsAccount < Account #should receive parent classess attributes like is_negative
		def initialize(id, balance, open_date)
			super # should include ref: http://rubylearning.com/satishtalim/ruby_overriding_methods.html
			check_low_balance
		end

  	def check_low_balance
			unless balance > 1000
				raise ArgumentError.new("Your balance must be $10 or more!")
			end
		end

		# withdraws money and debits fee appropraitely
		def withdraw(money, fee)
			if @balance - money - fee < 1000
				raise ArgumentError.new("Transaction Denied! Insufficient balance!")
			else
				@balance = @balance - money - fee
			end
			return see_balance
		end

		# Interest is a percentage
		def add_interest(rate)
			interest = @balance * rate / 100
			@balance = interest + balance
			return interest # puts see_balance # just return the interst not the balance  + intersest
		end
	end

	class CheckingAccount < Account

		def initialize(id, balance, open_date)
			super
			@check_count = 3
			see_balance
			#balance_to_low # remove this is a savings account method
			is_negative
		end

		# could withdraw be a helper method?
		def withdraw(money, fee) 
			if @balance - money - fee < 0
				raise ArgumentError.new("Transaction Denied! Insufficient balance!")
			else
				@balance = @balance - money - fee
			end
			return see_balance
		end

		
		def withdraw_using_check(amount, fee)
			if @check_count < 3
				# so if balance - withdraw overdrafts is greater than 10 (meaning negative 10 back to zero, ArgError should NOT raise)
				if @balance - amount < (-1000) # corrected logic for handling negative numbers
					raise ArgumentError.new("Transaction Denied! Insufficient balance!")
				else
					@balance = @balance - amount
					@check_count += 1
					return see_balance
				end
			else
				if @balance - amount - fee < (-1000)
					raise ArgumentError.new("Transaction Denied! Insufficient balance!")
				else
					@balance = @balance - amount - fee
					@check_count += 1
					return see_balance
				end
			end	
		end
		# consider making private
		def reset_checks
			@check_count = 0
			return check_count
		end

	end
end

# BEGIN TESTS
# checking1 = Bank::CheckingAccount.new(9919, 4000, 2016)
# . checking1.withdraw(1000)
# . checking1.withdraw_using_check(2000) # testing check < 3, no overdraft
# . checking1.withdraw_using_check(5100) # testing check < 3, with excess overdraft #works as expected raises argu defined at line 125
# . checking1.withdraw_using_check(5000)	# testing check < 3, with allowed overdraft, # initial fail throwing error with -5 overdrafts because I set overdraft value to 10 (10 cents) instead of 1000 ($10)
# . checking1.withdraw_using_check(2000) # testing check > 3, no overdraft
# . checking1.withdraw_using_check(5100) # testing check > 3, with excess overdraft
#puts checking1.withdraw(1000, 200)	# testing check > 3, with allowed overdraft
saver1 = Bank::SavingsAccount.new(9999, 2000, 2016)
puts saver1.add_interest(1) # ima a generous bank

