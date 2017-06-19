# This method return value wich match to regular exprassion
module Helper
  def verify(params)
    value = gets.strip if params[:value].nil?
    until Regexp.new(params[:matcher]).match(value)
      puts "(!) Please, enter #{params[:message]}"
      value = gets.strip.chomp
    end
    value
  end
end
