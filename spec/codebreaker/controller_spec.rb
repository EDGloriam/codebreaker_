require './lib/codebreaker/game'
require './lib/codebreaker/ui'
require './lib/codebreaker/controller'
require_relative 'test_data'


  RSpec.describe Controller do
    include TestData

    it 'replies correct' do
      # @controller = Controller.new
      # @ui = Ui.new
      # @controller.instance_variable_set(:@ui,@ui)
      puts test_data
      # test_data.each do |arr|
      #   cod = arr[0].split('').map{|item| item.to_i}
      #   @controller.reply_to(cod, arr[1])
      #   expect {@ui}.to output(arr[2]).to_stdout
      # end
    end
  end

