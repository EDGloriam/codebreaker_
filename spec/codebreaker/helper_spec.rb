
require './lib/codebreaker/helper'

  RSpec.describe 'Helper' do
    include Helper
    describe '#verify' do
      let(:params) {{ matcher: '^[\d]+$', message: 'a number '}}

      it "works. Return 10 if matcher requires a number"do
        expect(verify(params)).to eq('10')
      end

      xit "raise an exception when incorrect input" do
        # allow(subject). receive(:puts).with(any_args)
         expect(verify(params)).to output("(!) Please, enter a number").to_stdout
      end
    end
  end
