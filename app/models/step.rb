class Step < ActiveRecord::Base
  belongs_to :parent, :class_name => Step
  belongs_to :algorithm, :class_name => Algorithm
  has_many :children, :class_name => Step, :foreign_key => :parent_id

  def tree
    MathLearner::Tree.new(value).parse
  end
end
