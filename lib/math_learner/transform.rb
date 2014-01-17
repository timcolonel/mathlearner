module MathLearner
  class Transform
    def initialize(start, goal)
      @start = start
      @goal = goal
      @h = Heuristic.compute(@start, @goal)
      @history = [@start]
      @current = start
      puts "Transforming: #{@start.to_readable} into #{@goal.to_readable}"
    end

    def transform
      while @current != @goal
        found = false
        Algorithm.all.each do |algorithm|
          puts 'trying: '  + algorithm.name
          result = use_algorithm(algorithm)
          unless result.nil?
            @current = result
            @history << @current
            found = true
          end
        end

        puts 'Historiy: ' unless found
        puts @history unless found
        return nil unless found
      end
      @history
    end

    def use_algorithm(algorithm, node = nil)
      current = @current.clone
      node ||= current
      if transform_node(algorithm, current, node)
        return current
      elsif node.is_function?
        node.children.each do |child|
          result = use_algorithm(algorithm, child)
          unless result.nil?
            return result
          end
        end
      end
      nil
    end

    def transform_node(algorithm, root, node)
      matcher = algorithm.use(node)
      puts 'Use algo on: ' + node.to_readable
      unless matcher.nil?
        output = matcher.last.value_tree
        tmp =node.clone
        puts ' old : ' + @current.to_readable
        node.set(output)
        new_h = Heuristic.compute(root, @goal)
        puts 'worked, is ' + @h.to_s + ' < ' + new_h.to_s + ' ' + root.to_readable
        if new_h >= @h and not @history.include?(root)
          @h = new_h
          puts "better h #{@h} for #{output.to_readable}"
          return true
        else#set the node back
          node.set(tmp)
        end
      end
      false
    end
  end
end
