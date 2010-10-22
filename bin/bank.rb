require 'bank'
require 'bank/ledger'

bank=Bank.new()
a = bank.add_account(Bank::Account.new('A',1000))
ledger = Bank::Ledger.new(a)
b = bank.add_account(Bank::Account.new('B',5000))

a.deposit(50)
a.withdraw(100)
b.transfer(1000,a)



ledger.transactions.each do |transaction|
  puts transaction
end

puts "account: #{a.balance}"
puts "ledger: #{ledger.balance}"
  