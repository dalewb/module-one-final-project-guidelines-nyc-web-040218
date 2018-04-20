require 'bundler'

# require 'pry'
Bundler.require

@prompt = TTY::Prompt.new


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'

<<<<<<< HEAD
ActiveRecord::Base.logger = nil
=======

def welcome_prompt
>>>>>>> 4c14e7049130ffd4aeb4341bd05ab8a4a2f4ed58

def welcome_prompt
 choices = %w(Start Resume)
@response = @prompt.select("Would you like to start or resume a game?", choices)
@response
end

# if @user_type == "New"
# @user_name = prompt.ask("What is your name?")
#

def how_we_select_prompt
  choices = %w(Name Symbol)
  @prompt.select("How would you like to select your investment?", choices)
end

def user_check_prompt
@user_type = TTY::Prompt.new
choices = %w(New Existing)
@user_type.multi_select("Are you a new or existing user?", choices)
end


#if new user
def create_user
@new_name = @prompt.ask("What is your name?")
@user = User.create(name: @new_name, account_balance: 100)
end

# def set_password
#   @password = @prompt.mask("Set your password")
# end


def create_password
  prompt.mask("Enter your password")
end

def welcome_back
    @name = @prompt.ask("Welcome back to the IPO investment game! What's your username?")
    until User.unique_names.include?(@name)
      @name_second = @prompt.ask("Invalid name. Please type a valid name")
  end
  @user = User.find_by(name:@name)
  @user
end


    # name = gets.chomp
    # @user = User.create(name: name, account_balance: 100)


  def get_company_by_name
    @company = @prompt.select("Choose a company to invest in", Company.all_names)
    @company = Company.find_by(name: @company)
    # until Company.all_names.include?(@company)
    #   puts "Invalid company.  Please choose again."
    end

   def get_share_amount
    # @shares_select = prompt.slider("Shares:", max: 50, step: 1)
    @shares = @prompt.slider('Shares', max: 10, step: 1).to_f
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
     Transaction.create(company_id: @company.id, user_id: @user.id, num_of_shares: @shares, buy: true)
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
    @user.companies.all.map do |company|
      result = company.close_price.to_f * @user.find_num_shares(company)
      result.round(2)
    end
  end

  def initial_purchase
    @user.companies.all.map do |company|
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
    @user.companies.all.map do |company|
      puts "#{company.name}, Share Price: $#{company.open_price}"
    end
  end
  # Number of Shares: #{@user.find_num_shares(company)}"

  def view_all_companies?
    second_prompt = prompt.yes?("Would you like to view all available companies?") do ||
    end
  end

  def shares_for_company
    company = Company.find_by(name: @company).open_price.to_f
    allowed_shares = (@user.account_balance / company).floor
    puts "For #{@company}, you can purchase a maximum of #{allowed_shares} shares"
  end

  def user_interaction
<<<<<<< HEAD
    if how_we_select_prompt == "Name"
    get_company_by_name
    get_share_amount
  elsif how_we_select_prompt == "Symbol"
    get_company_by_symbol
=======
    get_company
    shares_for_company
>>>>>>> 4c14e7049130ffd4aeb4341bd05ab8a4a2f4ed58
    get_share_amount
  end
end

  def purchase_price
    @shares * @company.open_price.to_f
  end

  def valid_transaction?
    purchase_price <= @user.account_balance
  end

  def return_by_company
    company_names_by_percentage.map do |name, percentage|
<<<<<<< HEAD
    puts "You returned #{percentage}% for #{name}"
=======
      puts "You returned #{percentage}% for #{name}"
>>>>>>> 4c14e7049130ffd4aeb4341bd05ab8a4a2f4ed58
    end
  end

  def overall_percentage
    result = final_sale.reduce(:+) - initial_purchase.reduce(:+)
    percentage = (result / 100) * 100
    puts "You returned an overall percentage of #{percentage}%"
  end

  def company_names_by_percentage
    result = {}
    @user.companies.all.map { |company| result[company.name] = company.percent_change }
    result
  end

<<<<<<< HEAD
def game_logic
  change_balance
  make_transaction
  display_balance
  display_portfolio
end

def run_program
art = AsciiArt.new('./app/dollar-signs.jpg')
puts art.to_ascii_art(width: 120)
welcome_prompt
case @response
  when "Resume"
  welcome_back
  until @user.account_balance < lowest_open_price
    user_interaction
    until valid_transaction?
      puts "Looks like you're biting off more than you can chew! Please try again"
      user_interaction
    end
    game_logic
  end
end_game
  when "Start"
  create_user
  until @user.account_balance < lowest_open_price
    user_interaction
    until valid_transaction?
      puts "Looks like you're biting off more than you can chew! Please try again"
      user_interaction
    end
    game_logic
  end
end_game
end
end

=======
  def end_game
    investments_complete
    return_on_capital
    return_by_company
    overall_percentage
  end

  def game_logic
    change_balance
    make_transaction
    display_balance
    display_portfolio
  end
>>>>>>> 4c14e7049130ffd4aeb4341bd05ab8a4a2f4ed58
  # def get_company
  #   @company_name = prompt.select("Choose a company to invest in:", Company.all_names)
  # end

  # Hennessy Capital Acquisition III
  # iQIYI
  # Homology Medicines
  # Longfin
