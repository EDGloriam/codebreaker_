require_relative 'helper'
require_relative 'game'
require_relative 'ui'
require_relative 'player'

class Controller
  include Helper
  include Player
  def start
    loop do
      @game = Codebreaker::Game.new
      @user_input = ''
      @ui = Ui.new
      @game.attempts_left = @ui.set_attempts(matcher: '^[\d]+$', message: 'a number ')
      treatment_to_user
      save

      play = @ui.play_again(matcher: '^(y|n)$', message: "'y' or 'n' ")
      break if play == 'n'
    end
  end

  def treatment_to_user
    @game.attempts_left.times do
      @game.attempts_spent += 1
      @user_input = @ui.user_input
      (@user_input = @ui.user_input) until @user_input.match(/(hint|^[1-6]{4}$)/)
      break if code_hucked_with? @user_input
      router(@user_input)
    end
    result(@user_input)
  end

  def router(user_input)
    !!user_input.match(/hint/) ? process_hint : reply_to(@game.code, user_input)
  end

  def process_hint
    if @game.hint_avaliable?
      position = @ui.ask_position(matcher: '^[1-4]$', message:  'numder from 1 to 4')
      @ui.show_hint(formated_hint(position))
      @game.hint_avaliable = false
    else
      @ui.no_hint
    end
  end

  def formated_hint(position)
    hint = Array.new(4) { '*' }
    hint[position] = @game.hint(position)
    hint.join
  end

  def reply_to(sct_code, user_input)
    without_coinc = delete_coincidence(sct_code, to_array(user_input))
    plus = '+' * (4 - without_coinc.size)
    code_left = without_coinc.transpose[0]
    input_left = without_coinc.transpose[1]
    minus = '-' * (input_left.uniq.select{ |item| code_left.include?(item) }.size)
    @ui.show_result(plus, minus)
  end

  def result(user_input)
    if code_hucked_with? user_input
      @game.won = true
      @ui.congrats
    else
      @ui.condolences(@game.code.join)
    end
  end

  def code_hucked_with?(user_input)
    to_array(user_input) == @game.code
  end

  def to_array(user_input)
    user_input.split('').map(&:to_i)
  end

  def delete_coincidence(code, user_input)
    code.zip(user_input).delete_if { |item| item[0] == item[1] }
  end

  def save
    if @ui.save?
      name = set_name
      File.open('./lib/codebreaker/data/data.txt', 'a') do |file|
        file.write("==========\nDate: #{Time.now}\n")
        file.write("Player: #{name}\n")
        file.write("Won game: #{@game.won}\n")
        file.write("Spent attempts: #{@game.attempts_spent}\n")
      end
    end
  end
end
