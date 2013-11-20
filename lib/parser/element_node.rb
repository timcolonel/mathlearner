module Parser
  class ElementNode
    attr_accessor :element, :value

    def initialize(element = nil, value = nil)
      @element = element
      @value = value
    end

    def extract_map(mapping)
      return mapping[value.to_s]
    end

    def to_s
      "#{@element}(#{@value})"
    end

    def to_readable
      value.to_s
    end
  end
end