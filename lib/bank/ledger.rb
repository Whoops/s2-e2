class Bank
  class Ledger
    
    attr_accessor :account, :transactions, :balance
    
    def initialize(account)
      @account = account
      @transactions = []
      @transactions << Transaction.new(:deposit,account.balance,account.balance)
      @balance=account.balance
      hook_account
    end
    
    private
    def hook_account
      @account.on_deposit do |amount, balance|
        @transactions << Transaction.new(:deposit,amount, balance)
        @balance += amount
      end
      
      @account.on_withdraw do |amount, balance|
        @transactions << Transaction.new(:withdraw,amount, balance)
        @balance -= amount
      end
      
    end
    
    class Transaction
      attr_accessor :type, :amount, :balance
      attr_reader :date
      def initialize(type,amount,balance)
        @type = type
        @amount = amount
        @balance = balance
        @date = Time.now
      end
      
      def deposit?
        @type == :deposit
      end
      
      def to_s
        "#{@date.strftime('%m/%d/%y %I:%M%p')}\t" +
        (deposit? ? '+' : '-') +
        "#{@amount}\t#{@balance}"
      end
    end
    
  end
end