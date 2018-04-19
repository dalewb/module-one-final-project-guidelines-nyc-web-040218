class User < ActiveRecord::Base
  has_many :transactions
  has_many :companies, through: :transactions

  def find_num_shares(company)
<<<<<<< HEAD
    return_company = self.transactions.select do |trans|
      company.id == trans.company_id
=======
  return_company = self.transactions.all.select do |trans|
    company.id == trans.company_id
>>>>>>> 19c84120c8821f5af34368bde65e0127699e2a4a
    end
  final_return = return_company.map { |e| e.num_of_shares }
    final_return.reduce(:+)
  end

end



# def find_shares
#   self.companies.map { |e| e. }
