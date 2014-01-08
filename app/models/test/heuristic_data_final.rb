class Test::HeuristicDataFinal < ActiveRecord::Base
  has_many :expressions, :class_name =>  Test::HeuristicData, :foreign_key => 'final_id'
end
