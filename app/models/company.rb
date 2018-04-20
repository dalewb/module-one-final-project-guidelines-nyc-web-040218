class Company < ActiveRecord::Base
  has_many :transactions
  has_many :users, through: :transactions

  def self.all_names
    self.all.map {|company| company.name}
  end

  def highest_investment
    count = Hash.new(0)
    self.transactions.each do |transaction|
      count[transaction.user] += transaction.num_of_shares
    end
    count
  end



end
