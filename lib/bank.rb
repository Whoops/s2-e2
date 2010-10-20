class Bank
  def initialize()
    @accounts={}
  end
  
  def account(name)
    @accounts[name]
  end
  
  def add_account(acc)
    @accounts[acc.name]=acc
  end
  
  class Account
    attr_accessor :name
    attr_reader :balance
    
    def initialize(name, initial_deposit=0)
      @name=name
      @balance=initial_deposit
      @deposit_handlers=[]
      @withdraw_handlers=[]
    end
    
    def deposit(amount)
      @balance+=amount
      @deposit_handlers.each { |handler| handler.call(amount, balance) }
    end
    
    def withdraw(amount)
      @balance-=amount
      @withdraw_handlers.each { |handler| handler.call(amount, balance) }
    end
    
    def transfer(amount, account)
      account.deposit(amount)
      withdraw(amount)
    end
      
    
    def on_deposit(&block)
      @deposit_handlers << proc &block
    end
    
    def on_withdraw(&block)
      @withdraw_handlers << proc &block
    end
    
  end
end