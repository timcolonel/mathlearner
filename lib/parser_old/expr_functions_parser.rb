module MathLearner
  class ExprFunctionsParser
    def initialize(text)
      @text = text
    end

    def for(expr, speparator =nil, max=-1)
      separator ||= ','
      elements = []
      @text.split(separator).each do |string|
        elements << Element.new(string).parse
      end
      elements
    end


    def self.parse(function, parser)
      parser = ExprFunctionsParser.new(string)
      eval(function, parser.binding)
    end
  end

end