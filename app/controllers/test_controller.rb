class TestController < ApplicationController
  def heuristic
    final = 'b*a+a*c'
    @comparaisons = {}
    Test::HeuristicDataFinal.all.each do |final|
      hash = {}
      @comparaisons[final.value]=hash
      compare(hash, final.value, final.value)
      final.expressions.each do |exp|

        compare(hash, exp.value, final.value)
      end
    end
  end

  def compare(hash, exp1, final)
    tree1 = Parser::Tree.new(exp1).parse
    tree2 = Parser::Tree.new(final).parse

    hash[exp1] = Matcher::Heuristic.compute(tree1, tree2)

  end
end
