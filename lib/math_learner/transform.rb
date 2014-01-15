module MathLearner
  class Transform
    def self.transform(start, goal)
      h = Heuristic.compute(start, goal)
      history = [start]
      current = start
      while current != goal
        found = false
        Algorithm.all.each do |algorithm|
          matcher = algorithm.use(current)
          unless matcher.nil?
            output = matcher.last.value_tree
            new_h = Heuristic.compute(output, goal)
            if new_h > h
              h = new_h
              current = output
              history << current
              puts "better h #{h} for #{output}"
              found = true
              break
            end
          end
        end
        return nil unless found
      end
      history
    end
  end
end
