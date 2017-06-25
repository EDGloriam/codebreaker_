require './lib/codebreaker/ui'

RSpec.describe 'Ui' do
  context 'new object' do
    it 'says Welcome' do
      expect { Ui.new }.to output("Welcome to the game!\n").to_stdout
    end
  end
end
