require_relative '../config/environment'
require 'pry'

<<<<<<< HEAD
# welcome_prompt
# binding.pry
# until @user.account_balance < lowest_open_price
#   user_interaction
#   until valid_transaction?
#     puts "Looks like you're biting off more than you can chew! Please try again"
#     user_interaction
#   end
# game_logic
# end
# end_game
#
# case object
# when condition
#
# end
run_program

# welcome_prompt
# case @response
#   when "Resume"
#   welcome_back
#   until @user.account_balance < lowest_open_price
#     user_interaction
#     until valid_transaction?
#       puts "Looks like you're biting off more than you can chew! Please try again"
#       user_interaction
#     end
#     game_logic
#   end
# end_game
#   when "Start"
#   create_user
#   until @user.account_balance < lowest_open_price
#     user_interaction
#     until valid_transaction?
#       puts "Looks like you're biting off more than you can chew! Please try again"
#       user_interaction
#     end
#     game_logic
#   end
# end_game
# end
# choices = %w(Start Resume)
# @selection = @prompt.multi_select("Would you like to start or resume a game?", choices)
# end
=======
ActiveRecord::Base.logger.silence do
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
end
>>>>>>> 4c14e7049130ffd4aeb4341bd05ab8a4a2f4ed58
