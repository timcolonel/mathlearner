class Function < ActiveRecord::Base
  def self.get_function(string)
    Function.all.each do |function|
      return function if string.input(Regexp.new(function.pattern))
    end
    nil
  end
end
