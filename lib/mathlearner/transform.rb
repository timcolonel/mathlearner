module MathLearner
  class Transform
    def transform(start, goal)
      h =  Heuristic.compute(start, goal)
      current = start
      Algorithm.all.each do |algortihm|
        match = algortihm.match(current)
        unless match.nil?
          output =
        end
      end
    end
  end
end
