require 'pry'

class User < ActiveRecord::Base
  has_many :transactions
  has_many :companies, through: :transactions

  def find_num_shares(company)
<<<<<<< HEAD
  return_company = self.transactions.all.select do |trans|
    company.id == trans.company_id
=======
    return_company = self.transactions.select do |trans|
      company.id == trans.company_id
>>>>>>> 4c14e7049130ffd4aeb4341bd05ab8a4a2f4ed58
    end
    final_return = return_company.map { |e| e.num_of_shares }
    final_return.reduce(:+)
  end
<<<<<<< HEAD
  def self.unique_names
    User.uniq.pluck(:name)
  end
=======

  def shares_by_company_name
    count = Hash.new(0)
    self.transactions.all.map do |transaction|
      count[transaction.company.name] += transaction.num_of_shares
    end
    count
  end

  def all_positive_returns
    count = 0
    names = []
    self.transactions.all.each do |transaction|
      trans_info_hash = transaction_info(transaction).values.first
      company_name = transaction_info(transaction).keys.first
      if trans_info_hash[:percent] > 0 && !names.include?(company_name)
        count += 1
        names << company_name
      end
    end
  end

  def view_all_negative_returns
    count = 0
    names = []
    self.transactions.all.each do |transaction|
      trans_info_hash = transaction_info(transaction).values.first
      company_name = transaction_info(transaction).keys.first
      if trans_info_hash[:percent] < 0 && !names.include?(company_name)
        puts "#{company_name}"
        puts "  Percent Decrease: #{trans_info_hash[:percent]}%"
        puts "  Monetary Loss: $#{trans_info_hash[:money].round(2)}"
        count += 1
        names << company_name
      end
    end
    if count == 0
      puts "Well done!  You do not have any negative returns."
    end
  end

  def view_all_positive_returns
    count = 0
    names = []
    self.transactions.all.each do |transaction|
      trans_info_hash = transaction_info(transaction).values.first
      company_name = transaction_info(transaction).keys.first
      if trans_info_hash[:percent] > 0 && !names.include?(company_name)
        puts "#{company_name}"
        puts "  Percent Increase: #{trans_info_hash[:percent]}%"
        puts "  Monetary Gain: $#{trans_info_hash[:money].round(2)}"
        count += 1
        names << company_name
      end
    end
    if count == 0
      puts "I'm sorry, you do not have any negative returns."
    end
  end

  def transaction_info(transaction)
    result = {}
    info = {}
    company_name = transaction.company.name
    shares = self.shares_by_company_name[company_name]
    info[:shares] = shares
    percent = transaction.company.percent_change.to_f
    info[:percent] = percent
    o_price = transaction.company.open_price.to_f
    info[:o_price] = o_price
    c_price = transaction.company.close_price.to_f
    info[:c_price] = c_price
    money = (c_price * shares) - (o_price * shares)
    info[:money] = money
    result[company_name] = info
    result
  end

  def all_transaction_info
    self.transactions.all.map {|trans| transaction_info(trans)}.uniq
  end

  def greatest_monetary_increase
    current_fund = 0
    fund_company = ""
    self.all_transaction_info.each do |company|
      if company.values.first[:money] > current_fund
        current_fund = company.values.first[:money]
        fund_company = company.keys.first
      end
    end
    if current_fund > 0
      puts "$#{current_fund.round(2)} from #{fund_company}."
    else
      puts "You have no monetary increase."
    end
  end

  def greatest_monetary_loss
    current_fund = 0
    fund_company = ""
    self.all_transaction_info.each do |company|
      if company.values.first[:money] < current_fund
        current_fund = company.values.first[:money]
        fund_company = company.keys.first
      end
    end
    if current_fund < 0
      puts "$#{current_fund.round(2)} from #{fund_company}."
    else
      puts "You have no monetary decrease."
    end
  end





>>>>>>> 4c14e7049130ffd4aeb4341bd05ab8a4a2f4ed58
end




# def find_shares
#   @user.companies.map { |e| e. }
