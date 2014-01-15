module MathLearner
  class ElementNode
    attr_accessor :element, :value

    def initialize(element = nil, value = nil)
      @element = element
      @value = value
    end

    def get_value(mapping)
      return mapping[value.to_s]
    end

    def to_s
      "#{@element}(#{@value})"
    end

    def to_readable
      value.to_s
    end

    #Helper function
    def function
      nil
    end

    def is_element?
      true
    end
    def is_function?
      false
    end

    def ==(other)
      value == other.value and element == other.element
    end
  end
end