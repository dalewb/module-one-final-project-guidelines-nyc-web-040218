require_relative '../config/environment'

welcome
until @user.account_balance < lowest_open_price
  user_interaction
  until valid_transaction?
    puts "Looks like you're biting off more than you can chew! Please try again"
    user_interaction
  end
  change_balance
  make_transaction
  display_balance
  display_portfolio
end
investments_complete
return_on_capital
