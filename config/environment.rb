require 'bundler'
# require 'pry'
Bundler.require
prompt = TTY::Prompt.new

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'

def welcome_prompt

end


def how_we_select_prompt
  @company_search_type = TTY::Prompt.new
  choices = %w(Symbol Name)
@company_search_type.multi_select("Select company by:", choices)
end





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
    @user.save
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
    puts "Your monetary return is $#{result.round(2)}"
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
      puts "#{company.name}, Share Price: $#{company.open_price}"
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

  def return_by_company
    company_names_by_percentage.map do |name, percentage|
    puts "You returned #{percentage}% for #{name}"
  end
end

def company_names_by_percentage
  result = {}
  @user.companies.all.map { |company| result[company.name] = company.percent_change }
result
end

def end_game
  investments_complete
  return_on_capital
  return_by_company
end

def game_logic
  change_balance
  make_transaction
  display_balance
  display_portfolio
end
  # def get_company
  #   @company_name = prompt.select("Choose a company to invest in:", Company.all_names)
  # end
