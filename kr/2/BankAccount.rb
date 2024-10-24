class BankAccount
  attr_reader :balance, :credit_limit
  def initialize(credit_limit) 
    @balance = 0.0
    @credit_limit = credit_limit
  end
  def get_balance
    puts "Balance: #@balance UAH. Credit limit: #@credit_limit UAH"
  end
  def put_money(money)
    if money > 0
      @balance += money
      puts "You contributed #{money} UAH"
    else
      puts "The amount must be greater than 0."
    end
  end
  def withdraw_money(money)
    available_funds = @balance + @credit_limit
    if money > 0
      puts "You want to withdraw #{money} UAH"
      if money <= available_funds 
        @balance -= money
        puts "You withdrew #{money} UAH"
      else
        puts "Insufficient funds, even taking into account the credit limit."
      end
    else
      puts "The amount must be greater than 0."
    end
  end
end

firstAccount = BankAccount.new(10000)
firstAccount.put_money(30)
firstAccount.get_balance
firstAccount.withdraw_money(100000)
firstAccount.get_balance
firstAccount.withdraw_money(10)
firstAccount.get_balance