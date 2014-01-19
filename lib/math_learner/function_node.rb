module MathLearner
  class FunctionNode
    attr_accessor :children, :function


    def initialize(function = nil, children = [])
      @children = children
      @function = function
    end

    def permutation
      FunctionNodeEnumerator.new(self)
    end

    def to_s
      "#{@function.to_s}(#{@children.map { |x| x.to_s }.join(',')})"
    end

    def to_readable
      if @function.is_a? Operator
        if @children.size == 1
          "(#{@function.to_s}#{@children.first.to_readable})"
        else
        "(#{@children.map { |x| x.to_readable }.join(@function.to_s)})"
        end

      else
        "#{@function.to_s}(#{@children.map { |x| x.to_readable }.join(',')})"
      end
    end

    def all_functions
      functions = [@function]
      children.each do |child|
        if child.is_a? FunctionNode
          functions += child.all_functions
        end
      end
      functions
    end

    def functions_count
      functions = {@function => 1}
      children.each do |child|
        if child.is_a? FunctionNode
          child.functions_count.each do |function|
            functions[function] ||= 0
            functions[function] += 1
          end
        end
      end
      functions
    end

    def all_elements
      elements = []
      children.each do |child|
        if child.is_a? FunctionNode
          functions += child.all_elements
        elsif child.is_element?
          elements << child
        end
      end
      elements
    end

    def elements_count
      elements = {}
      children.each do |child|
        if child.is_a? FunctionNode
          child.elements_count.each do |element|
            elements[element] ||= 0
            elements[element] += 1
          end
        elsif child.is_element?
          elements[child] ||= 0
          elements[child] += 1
        end
      end
      elements
    end

    def is_function?
      true
    end

    def is_element?
      false
    end

    def ==(other)
      return false if function != other.function
      @children.each_with_index do |child, i|
        return false if child != other.children[i]
      end
      true
    end

    def set(function_node)
      @children = function_node.children
      @function = function_node.function
    end
  end
end