require './lib/codebreaker/game'
require_relative 'test_data'
module Codebreaker
  RSpec.describe Game do
    include TestData
    let(:game) { Game.new }
    let(:secret_code) { game.instance_variable_get(:@secret_code) }
    let(:attempts) { game.instance_variable_get(:@attempts_left) }
    let(:hint_avaliable) { game.instance_variable_get(:@hint_avaliable) }
    describe '#initialize' do
      context 'saves correct secret code' do
        it { expect(secret_code).not_to be_empty }
        it { expect(secret_code.size).to eq(4) }
        it { expect(secret_code.join).to match(/[1-6]/) }
      end

      it 'sets attempts to 0' do
        expect(attempts).to be_zero
      end

      it 'sets hint avaliable to true' do
        expect(hint_avaliable).to be true
      end
    end

    describe '#reply' do
      context "tells 'won' or 'lose'" do
        before(:each) { game.instance_variable_set(:@secret_code, [1, 2, 3, 4]) }

        it ':won if user guessed a secret code' do
          expect(game.reply('1234')).to eq(:won)
        end

        it ":lose if secret code didn't guessed while ran out of attempts" do
          expect(game.reply('1111')).to eq(:lose)
        end
      end

      context 'calls #route' do
        before(:each) { game.instance_variable_set(:@attempts_left, 1) }

        it "when user type 'hint'" do
          expect(game).to receive(:route).with('hint')
          game.reply('hint')
        end

        it "when user type '1234'" do
          expect(game).to receive(:route).with('1234')
          game.reply('1234')
        end
      end
    end

    describe '#route' do
      context 'changes attempts' do
        before(:each) { game.instance_variable_set(:@attempts_left, 2) }

        it 'decrease(-) attempts left value by 1' do
          expect { game.route('1345') }.to change { game.attempts_left }.by(-1)
        end

        it 'increase(+) attempts spent value by 1' do
          expect { game.route('1345') }.to change { game.attempts_spent }.by(1)
        end
      end

      it 'calls #find_plus_minus when user input 4 numbers' do
        expect(game).to receive(:find_plus_minus).with('1234')
        game.route('1234')
      end

      it "calls #process_hint when user input 'hint'" do
        expect(game).to receive(:process_hint)
        game.route('hint')
      end
    end

    describe '#find_plus_minus' do
      it "displays '+' and '-' correct" do
        test_data.each do |example|
          cod = example[0].split('').map(&:to_i)
          game.instance_variable_set(:@secret_code, cod)
          expect(game.find_plus_minus(example[1])).to eq(example[2].to_s)
        end
      end

      it 'outputs ++-- when code: 5143 and user gues: 4153' do
        cod = '5143'.split('').map(&:to_i)
        game.instance_variable_set(:@secret_code, cod)
        expect(game.find_plus_minus('4153')).to eq('++--')
      end
    end

    describe '#process_hint' do
      it "says 'no hint' if user spend all hints" do
        game.instance_variable_set(:@hint_avaliable, false)
        expect(game.process_hint).to eq('no hint')
      end

      it 'calls #formated_hint' do
        expect(game).to receive(:formated_hint)
        game.process_hint
      end

      xit "sets hint_avaliable to 'false'" do
        expect { game.process_hint }.to change { game.hint_avaliable }.to(false)
      end
    end

    describe '#code_hucked_with?' do
      it 'returns true if code is equal to user input' do
        game.instance_variable_set(:@secret_code, [1, 2, 3, 4])
        expect(game.code_hucked_with?('1234')).to be true
      end
    end
  end
end
