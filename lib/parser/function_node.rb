module Parser
  class FunctionNode
    attr_accessor :children, :function

    def initialize(function = nil)
      @children = []
      @function = function
    end

    def to_s
      "#{@function.to_s}(#{@children.map { |x| x.to_s }.join(',')})"
    end

    def to_readable
      "(#{@children.map { |x| x.to_readable }.join(@function.to_s)})"
    end
  end
end