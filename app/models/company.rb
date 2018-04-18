class Company < ActiveRecord::Base
  has_many :transactions
  has_many :users, through: :transactions

  def self.all_names
    self.all.map {|company| company.name}
  end
end
