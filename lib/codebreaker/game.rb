module Codebreaker
  class Game
    attr_accessor :attempts_left, :attempts_spent, :hint_avaliable, :won

    def initialize
      @won = false
      @hint_avaliable = true
      @secret_code = Array.new(4).map { rand(1..6) }
      @attempts_left = 0
      @attempts_spent = 0
    end

    def hint_avaliable?
      @hint_avaliable
    end

    def hint(position)
      @secret_code[position]
    end

    def code
      @secret_code
    end
  end
end
