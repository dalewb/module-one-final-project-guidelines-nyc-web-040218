class User < ActiveRecord::Base
  has_many :transactions
  has_many :companies, through: :transactions

  def find_num_shares(company)
    return_company = self.transactions.select do |trans|
      company.id == trans.company_id
    end
    return_company.num_of_shares
  end

end
