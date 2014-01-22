require 'forwardable'
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

    def to_s
      @history.map { |x| "#{x[:node].to_readable}\t #{x[:operation]}" }.to_s
    end

    def include?(node)
      @history.each do |step|
        if step[:node] == node
          return true
        end
      end
      false
    end

    def each(&block)
      @history.each(&block)
    end
  end
end