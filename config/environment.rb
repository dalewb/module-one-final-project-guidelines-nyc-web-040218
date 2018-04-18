require 'bundler'
# require 'pry'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'

def welcome
    puts "Welcome!  This is an IPO investment game."
    puts "Please enter your name:"
    name = gets.chomp
    @user = User.create(name: name, account_balance: 100)
  end

  def get_company
    # @company_name =
    # prompt.select("Choose a company to invest in:", Company.all_names)
    puts "Choose a company to invest in:"
    @company = gets.chomp
    until Company.all_names.include?(@company)
      puts "Invalid company.  Please choose again."
      @company = gets.chomp
    end
  end

   def get_share_amount
    # @shares_select = prompt.slider("Shares:", max: 50, step: 1)
    puts "Select share amount:"
    @shares = gets.chomp.to_f
  end


  def change_balance
    @user.account_balance -= purchase_price
    @user.account_balance
    # binding.pry
  end

   def make_transaction
     if @user.account_balance < lowest_open_price && @shares <= 1
       puts "Insufficient funds for this transaction."
     else
     company = Company.find_by(name: @company)
     Transaction.create(company_id: company.id, user_id: @user.id, num_of_shares: @shares, buy: true)
   end
end

  # Investment class
  def display_balance
    puts "Your current balance is #{@user.account_balance}"
  end

  # Need to order by open_price but not getting correct number for query
  def investments_complete
    if @user.account_balance < lowest_open_price
      puts "Your account is empty #{@user.name}. Here's how you did!"
    end
  end

  # Investments
  def final_sale
    @user.companies.map do |company|
      result = company.close_price.to_f * @user.find_num_shares(company)
      result.round(2)
    end
  end

  def initial_purchase
    @user.companies.map do |company|
      result = company.open_price.to_f * @user.find_num_shares(company)
      result.round(2)
    end
  end

  def return_on_capital
    result = final_sale.reduce(:+) - initial_purchase.reduce(:+)
    puts result.round(2)
  end

  # thurman.final_sale
  # thurman.initial_purchase
  # thurman.return_on_capital

  def lowest_open_price
    hsh = {}
    Company.all.each do |el|
      hsh[el.open_price.to_f] = el
    end
    hsh.min_by {|k,v| k}[0]
  end




  def display_portfolio
    @user.companies.map do |company|
      puts "#{company.name}, Share Price: #{company.open_price}"
  end
end
  # Number of Shares: #{@user.find_num_shares(company)}"

  def view_all_companies?
    second_prompt = prompt.yes?("Would you like to view all available companies?") do ||
    end
  end

  def user_interaction
    get_company
    get_share_amount
  end

  def purchase_price
    @shares * Company.find_by(name: @company).open_price.to_f
  end

  def valid_transaction?
    purchase_price < @user.account_balance
  end

  # def get_company
  #   @company_name = prompt.select("Choose a company to invest in:", Company.all_names)
  # end
