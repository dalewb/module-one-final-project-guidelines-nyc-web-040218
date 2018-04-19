
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
  self.transactions.all.map do |trans|
    transaction_info(trans)
  end
end


# 1 See all transactions for a company by name
# Company class

  def see_all_transactions_by_name(company_name)
    Company.find_by(name: "#{company_name}").transactions
  end

# 2 See all transactions for a user
# User class

  # self.transactions

# 3 See all positive (+) % returns for a user (puts company names, percent return and monetary return)
# User class

  def shares_by_company_name
    count = Hash.new(0)
    self.transactions.all.map do |transaction|
      count[transaction.company.name] += transaction.num_of_shares
    end
    count
  end

  def view_all_positive_returns
    count = 0
    self.transactions.all do |transaction|
      company_name = transaction.company.name
      shares = self.shares_by_company_name[company_name]
      percent = transaction.company.percent_change.to_f
      o_price = transaction.company.open_price.to_f
      c_price = transaction.company.close_price.to_f
      money = (c_price * shares) - (o_price * shares)
      if percent > 0
        puts "Company: #{company_name}, Percent Increase: #{percent}, Monetary Return: #{money}"
        count += 1
      end
    end
    if count == 0
      puts "I'm sorry, ou do not have any positive returns."
    end
  end

# 4 See all negative (-) % returns for a user's companies

  def view_all_negative_returns
    count = 0
    self.transactions.all do |transaction|
      company_name = transaction.company.name
      shares = self.shares_by_company_name[company_name]
      percent = transaction.company.percent_change.to_f
      o_price = transaction.company.open_price.to_f
      c_price = transaction.company.close_price.to_f
      money = (c_price * shares) - (o_price * shares)
      if percent <= 0
        puts "Company: #{company_name}, Percent Decrease: #{percent}, Monetary Loss: #{money * -1}"
        count += 1
      end
    end
    if count == 0
      puts "Well done!  You do not have any negative returns."
    end
  end

  # 5 See highest monetary increase of all of a user's companies

    # User class
    def greatest_monetary_increase
      current_fund = 0
      self.all_transaction_info.each do |company|
        if company.values.first[:money] > current_fund
          current_fund = company.values.first[:money]
        end
      end
      current_fund
    end

  # 6 See highest monetary loss in all users companies

    # User class
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

  # 7 See most profitable transaction for a user

    # User class
    def most_profitable_transaction

    end

  # 8 See least profitable transaction for a user

    # User class
    def least_profitable_transaction

    end

  # 9 See a company's highest single investment from all users

    # Company class
    def highest_investment

    end

  # 10 Find investor with the highest stake in a company

    # Company class
    def user_with_highest_stake

    end

  # 11 Find user with the most shares

    # Company class
    def user_with_most_shares_in_company

    end

  # 12 Put in a message after user chooses a company saying 'You can buy x shares of this company'"

    #SUGGESTION
