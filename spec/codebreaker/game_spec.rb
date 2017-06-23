require './lib/codebreaker/game'
require_relative 'test_data'
module Codebreaker
  RSpec.describe Game do
    include TestData
    before(:all){ @game = Game.new }
    let(:secret_code) { @game.instance_variable_get(:@secret_code) }
    let(:attempts) { @game.instance_variable_get(:@attempts_left) }
    let(:hint_avaliable) { @game.instance_variable_get(:@hint_avaliable) }
    describe '#initialize' do
      context 'saves correct secret code' do
        it { expect(secret_code).not_to be_empty }
        it { expect(secret_code.size).to eq(4) }
        it { expect(secret_code.join).to match(/[1-6]/) }
      end

      # it 'sets attempts to 0' do
      #   expect(attempts).to be_zero
      # end

      it 'sets hint avaliable to true' do
        expect(hint_avaliable).to be true
      end
    end

    # describe '#hint' do
    #   before(:each) { @game.instance_variable_set(:@secret_code, [1,2,3,4]) }
    #   after(:each) { @game = Game.new }

    #   it 'returns 1 number from secret code ' do
    #     expect(@game.hint(1)).to eq(2)
    #   end
    # end

   it 'replies correct' do
      test_data.each_with_index do |example, i|
        puts "passed #{3+i}"
        cod = example[0].split('').map(&:to_i)
        @game.instance_variable_set(:@secret_code, cod)
        expect(@game.find_plus_minus(example[1])).to eq("#{example[2]}")
      end
    end

   xit 'replies correct. one example' do
      exampl = %w[1115 1231 +-]
      cod = exampl[0].split('').map(&:to_i)
      @game.instance_variable_set(:@secret_code, cod)
      # puts @game.find_plus_minus(exampl[1])
      expect(@game.find_plus_minus(exampl[1])).to eq("#{exampl[2]}")
    end

  end
end
