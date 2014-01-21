class TestController < ApplicationController
  def heuristic
    @comparisons = {}
    Test::HeuristicDataFinal.all.each do |final|
      hash = {}
      @comparisons[final.value]=hash
      compare(hash, final.value, final.value)
      final.expressions.each do |exp|

        compare(hash, exp.value, final.value)
      end
    end

    tree1 = MathLearner::Tree.new('a*(b-c)').parse
    tree2 = MathLearner::Tree.new('(-c)*a+a*b)').parse

    @transformation = MathLearner::Transform.new(tree1, tree2).transform
  end

  def compare(hash, exp1, final)
    tree1 = MathLearner::Tree.new(exp1).parse
    tree2 = MathLearner::Tree.new(final).parse

    hash[exp1] = MathLearner::Heuristic.compute(tree1, tree2)

  end
end
