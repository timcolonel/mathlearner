module MathLearner
  class Transform
    def initialize(start, goal)
      @start = start
      @goal = goal
      @h = Heuristic.compute(@start, @goal)
      @history = TransformHistory.new(@start)
      @current = start
      @badmoves = []
      puts "Transforming: #{@start.to_readable} into #{@goal.to_readable}"
    end

    def transform
      count = 0
      while @current != @goal
        found = false
        Algorithm.all.each do |algorithm|
          puts 'trying: ' + algorithm.name + ' : ' + algorithm.input.value
          result = use_algorithm(algorithm)
          unless result.nil?
            @current = result
            @history.add(@current, algorithm)
            found = true
            break
          end
        end
        unless found
          @badmoves << @current
          if @history.size <= 1
            return nil
          else
            puts 'Old current: ' + @current.to_readable
            puts 'Poping: ' +@history.to_s
            @history.pop
            @current = @history.last_node
            puts 'NEw current: ' + @current.to_readable
          end
        end
        puts '=========================================================='
        puts 'Historty: ' + @history.to_s
        puts 'Current: ---------------'
        puts @current.to_readable + ' - ' + @goal.to_readable
        #break if count > 2
        count +=1
      end
      @history
    end

    def use_algorithm(algorithm, current = nil, node = nil)
      current ||= @current.clone_nested
      node ||= current
      if transform_node(algorithm, current, node)
        return current
      elsif node.is_function?
        node.children.each do |child|
          result = use_algorithm(algorithm, current, child)
          unless result.nil?
            return result
          end
        end
      end
      nil
    end

    def transform_node(algorithm, root, node)
      matcher = algorithm.use(node)
      puts "\tUse algo on: " + node.to_readable
      unless matcher.nil?
        output = matcher.last.value_tree
        tmp =node.clone
        puts ' old : ' + @current.to_readable
        puts 'Historty bef: ' + @history.to_s
        node.set(output)
        new_h = Heuristic.compute(root, @goal)
        puts 'worked, is ' + @h.to_s + ' < ' + new_h.to_s + ' ' + root.to_readable
        puts 'Badmoves: ' + @badmoves.map { |x| x.to_readable }.to_s
        puts 'Historty: ' + @history.to_s
        puts 'inc: ' + @badmoves.include?(root).to_s + ' - ' + @history.include?(root).to_s
        if not @badmoves.include?(root) and not @history.include?(root)
          @h = new_h
          puts "better h #{@h} for #{output.to_readable}"
          return true
        else #set the node back
          node.set(tmp)
        end
      end
      false
    end
  end
end
