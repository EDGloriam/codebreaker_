require_relative 'helper'

class Ui
  include Helper
  def initialize
    puts 'Welcome to the game!'
  end

  def greeting
    puts 'Welcome to the Codebreaker'
  end

  def set_attempts(params)
    puts 'How many attempts do you need, to break the code?'
    verify(params).to_i
  end

  def user_input(params)
    puts "Please, enter 4 numbers in range from 1 to 6 or type 'hint'"
    verify(params)
  end

  def ask_position(params)
    puts 'What posotion would you like to open? (1,2,3,4)'
    verify(params).to_i - 1
  end

  def user_try(params)
    verify(params)
  end

  def show_hint(hint)
    puts hint
  end

  def no_hint
    puts '(!)There are no hints any more'
  end

  def show_plus_minus(plus_minus)
    puts plus_minus
  end

  def congratulations
    puts 'Congratulations, you breake the code!'
  end

  def sympathy(code)
    puts "Unfortunately, you lose. Secret code was : #{code}"
  end

  def play_again(params)
    puts 'Play again? (y/n)'
    verify(params)
  end

  def set_name
    puts 'Enter your name:'
    gets.strip.capitalize
  end

  def save?
    puts 'Would you like to save the result? (y/n)'
    return true if gets.strip.chomp == 'y'
  end
end
