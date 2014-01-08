class Test::HeuristicData < ActiveRecord::Base
  belongs_to :final, :class_name => Test::HeuristicDataFinal

  def to_s
    value
  end
end
