require_relative 'helper'
require_relative 'game'
require_relative 'ui'

class Controller
  include Helper
  def start
    loop do
      @game = Codebreaker::Game.new
      @ui = Ui.new
      @game.attempts_left = @ui.set_attempts(matcher: '^[\d]+$', message: 'a number ') - 1
      treatment_to_user
      save
      play_again = @ui.play_again(matcher: '^(y|n)$', message: "'y' or 'n' ")
      break if play_again == 'n'
    end
  end

  def treatment_to_user
    loop do
      user_input = @ui.user_input(
        matcher: '(hint|^[1-6]{4}$)',
        message: "'hint' or 4 numbers"
      )
      reply = process_reply(@game.reply(user_input))
      break if [:won, :lose].include? reply
    end
  end

  def process_reply(game_answer)
    case game_answer
    when String
      do_when_string(game_answer)
    when Symbol
      game_answer == :won ? @ui.congratulations : @ui.sympathy(@game.secret_code)
    end
    game_answer
  end

  def do_when_string(string)
    case string
    when /[\d]/
      @ui.show_plus_minus(string)
    when 'no_hint'
      @ui.no_hint
    else
      @ui.show_hint(string)
    end
  end

  def save
    if @ui.save?
      name = @ui.set_name
      File.open('data/data.txt', 'a') do |file|
        file.write("==========\nDate: #{Time.now}\n")
        file.write("Player: #{name}\n")
        file.write("Won game: #{@game.won}\n")
        file.write("Spent attempts: #{@game.attempts_spent}\n")
      end
    end
  end
end

# z = Controller.new
# z.start