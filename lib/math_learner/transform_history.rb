module MathLearner
  class TransformHistory
    def initialize(first = nil)
      @history = []
      @history << {:node => first} unless first.nil?
    end

    def add(node, operation = nil)
      @history << {:node => node, :operation => operation}
    end

    def pop
      @history.pop
    end

    def last_node
      @history.last[:node]
    end

  end
end