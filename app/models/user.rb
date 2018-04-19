class User < ActiveRecord::Base
  has_many :transactions
  has_many :companies, through: :transactions

  def find_num_shares(company)
  return_company = self.transactions.all.select do |trans|
    company.id == trans.company_id
    end
  final_return = return_company.map { |e| e.num_of_shares }
    final_return.reduce(:+)
  end

end



# def find_shares
#   self.companies.map { |e| e. }
