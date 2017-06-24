require_relative 'helper'

module Codebreaker
  class Game
    include Helper
    attr_accessor :attempts_left, :won, :attempts_spent
    attr_reader :secret_code

    def initialize
      @hint_avaliable = true
      @secret_code = generate_code
      @attempts_spent = 0
      @attempts_left = 0
    end

    def generate_code
      Array.new(4).map { rand(1..6) }
    end

    def reply(input)
      return @won = :won if code_hucked_with? input
      return @won = :lose if @attempts_left.zero?
      route(input)
    end

    def route(input)
      @attempts_left -= 1
      @attempts_spent += 1
      return find_plus_minus(input) if !!input.match(/[\d]/)
      process_hint
    end

    def find_plus_minus(user_input)
      half_coincidence = delete_coincidence(secret_code, to_array(user_input))
      plus = '+' * (4 - half_coincidence.size)
      code_left = half_coincidence.transpose[0]
      input_left = half_coincidence.transpose[1]
      code_left = delete_if_need(code_left, input_left)
      minus = '-' * (code_left.size - without_minus_size(code_left, input_left))
      plus + minus
    end

    def delete_if_need(code,input)
      code.each_with_index do |elem, i|
        next if input.count(elem).zero?
        code.delete_at(i) if code.count(elem) > input.count(elem)
      end
    end

    def delete_coincidence(code, user_input)
      code.zip(user_input).delete_if { |item| item[0] == item[1] }
    end

    def without_minus_size(code, input)
      code.delete_if { |item| input.include?(item) }.size
    end

    def code_hucked_with?(user_input)
      to_array(user_input) == secret_code
    end

    def process_hint
      return 'no_hint' unless @hint_avaliable
      @hint_avaliable = false
      formated_hint
    end

    def formated_hint
      hint = Array.new(4) { '*' }
      position = rand(0..3)
      hint[position] = @secret_code[position]
      hint.join
    end
  end
end
