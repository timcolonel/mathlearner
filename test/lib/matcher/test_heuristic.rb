ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)

class TestHeuristic
  def self.test_heuristic
    puts 'Comparing: '
    puts compare('a*b+a*c', 'b*a+a*c')
    puts compare('a*(b+c)', 'b*a+a*c')
    puts '----'
  end


end


