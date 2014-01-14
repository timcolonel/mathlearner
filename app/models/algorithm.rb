class Algorithm < ActiveRecord::Base
  has_many :steps, :class_name => Step
  has_one :input, -> { where parent_id: nil }, :class_name => Step
  has_many :outputs, -> { where output: true }, :class_name => Step


  def matcher(tree)
    matcher = MathLearner::Matcher.new
    if matcher.input(tree, input.tree).nil?
      nil
    else
      matcher
    end
  end

  def use(tree)
    matcher = matcher(tree)
    return nil if matcher.nil?
    step = input
    until step.children.empty?
      step = step.children.first #Temporary should be multiple step if conditions
      matcher.transform(step.tree)
    end
    matcher
  end
end
