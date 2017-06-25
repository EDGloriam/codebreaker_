require './lib/codebreaker/helper'

RSpec.describe 'Helper' do
  let(:params) { { matcher: '^[\d]+$', message: 'a number ' } }
  class Test
    include Helper
  end
  subject { Test.new }

  describe '#verify' do
    it 'returns 10 if matcher requires a number' do
      allow(subject).to receive(:gets).and_return('10')
      expect(subject.verify(params)).to eq('10')
    end

    it 'raise an exception when incorrect input'
  end

  describe '#to_array' do
    it 'converts string into array' do
      expect(subject.to_array('1234')).to eq([1, 2, 3, 4])
    end
  end
end
