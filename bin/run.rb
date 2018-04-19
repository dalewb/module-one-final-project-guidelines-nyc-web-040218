require_relative '../config/environment'
require 'pry'

how_we_select_prompt
welcome
until @user.account_balance < lowest_open_price
  user_interaction
  until valid_transaction?
    puts "Looks like you're biting off more than you can chew! Please try again"
    user_interaction
  end
game_logic
end
end_game
