# Create a SavingsAccount class which should inherit behavior from the Account class. It should include the following updated functionality:
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
# [ ] Create a CheckingAccount class which should inherit behavior from the Account class. It should include the following updated functionality:

# [ ] Updated withdrawal functionality:
# 	() Each withdrawal 'transaction' incurs a fee of $1 that is taken out of the balance. Returns the updated account balance.
# 	() Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
# 	() withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
#   () Allows the account to go into overdraft up to -$10 but not any lower
#   () The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee
#[ ] reset_checks: Resets the number of checks used to zero
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

		def balance_to_low
			unless @balance > 10000
	  		 raise ArgumentError.new("Your balance must be $10 or more!")
	  	end
  	end

		def see_balance
			return @balance
		end

		# this is Accounts class methods
		def withdraw(money)
			@balance = @balance - money
			is_to_low
			see_balance
		end

		def deposit(money)
			@balance = @balance + money 
			is_to_low
			see_balance
		end
	end


	class SavingsAccount < Account #should receive parent classess attributes like is_negative
		def initialize(id, balance, open_date)
			super
			check_low_balance
		end

  	def check_low_balance
			unless balance > 1000
				raise ArgumentError.new("Your balance must be $10 or more!")
			end
		end

		# withdraws money and debits fee appropraitely
		def withdraw(money)
			if @balance - money - 200 < 1000
				raise ArgumentError.new("Transaction Denied! Insufficient balance!")
			else
				@balance = @balance - money - 200
			end
			see_balance
		end

		# Interest is a percentage
		def add_interest(rate)
			interest = @balance * rate / 100
			@balance = interest + balance
			see_balance
		end

  end

end

saver1 = Bank::SavingsAccount.new(9999, 2000, 2016)
# puts saver1.check_low_balanrce
puts saver1.see_balance
puts saver1.add_interest(0.25)