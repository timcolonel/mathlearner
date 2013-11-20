module Matcher
  class FunctionMatchNode
    attr_accessor :function, :children

    def initialize(function)
      @function = function
      @children = {}
    end 

    def to_s
      "#{@function.to_s}(#{@children.map { |k, v| "#{k} => #{v}" }.join(',')})"
    end

    def get_element
      node = Parser::FunctionNode.new(function)
      node.children = children.map do |k, v|
        if v.is_a? FunctionMatchNode
          v.get_element
        else
          v.value
        end
      end
      node
    end
  end
end