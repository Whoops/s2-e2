$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)),'..','lib')
require 'bank'
require 'rubygems'
require 'mocha'

describe Bank do
  
  before(:each) do
    @bank = Bank.new
    @bank.add_account Bank::Account.new('A', 1000)
    @account = @bank.account('A')
  end
  
  it "should call deposit observer on deposit" do    
    callback = @account.on_deposit { |a,b| b }
    callback.expects(:call).with(50,1050)
    
    @account.deposit 50
  end
  
  it "should call withdraw observer on withdrawl" do
    callback = @account.on_withdraw { |a,b| b }
    callback.expects(:call).with(50,950)
    
    @account.withdraw 50
  end
  
  it "should call both observers on transfer" do
    b = Bank::Account.new('B', 5000)
    withdraw = b.on_withdraw { |a,b| b }
    deposit = @account.on_withdraw { |a,b| b }
    
    withdraw.expects(:call).with(1000,4000)
    deposit.expects(:call).with(1000,2000)
    
    b.transfer(1000,@account)
  end
  
end