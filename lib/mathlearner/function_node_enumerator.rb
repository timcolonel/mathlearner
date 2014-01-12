module MathLearner
  class FunctionNodeEnumerator
    def initialize(node, skip_first = false)
      @node = node.clone
      @children = @node.children.map do |x|
        if x.is_a? FunctionNode
          FunctionNodeEnumerator.new(x, true)
        else
          x
        end
      end
      @permutation = nil
      @current = @children
      if skip_first
        @permutation = @children.permutation
        @current = @permutation.next
      end

    end

    def next
      if @permutation.nil?
        @permutation = @children.permutation
        @current = @permutation.next
      else
        begin
          increase
        rescue StopIteration #Mean we have permuted all children
          @current = @permutation.next
        end
      end
      to_node
    end

    def reset
      @permutation.rewind
      @current = @permutation.next
    end

    def to_node
      FunctionNode.new(@node.function , @current.map do |x|
        if x.is_a? FunctionNodeEnumerator
          x.to_node
        else
          x
        end
      end)
    end

    def to_s
      to_node.to_s
    end

    def increase(index=0)
      if index >= @children.size
        raise StopIteration
      end
      child= @current[index]
      if child.is_a? FunctionNodeEnumerator
        begin
          child.next
        rescue StopIteration
          child.reset
          increase(index+1)
        end
      else
        increase(index +1)
      end
    end
  end
end