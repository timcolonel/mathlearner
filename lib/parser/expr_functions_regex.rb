module Parser
  class ExprFunctionsRegex
    def for(expr, speparator =nil, max=-1)
      separator ||= ''
      result = ''
      if max = -1
        result = "(#{expr}\\#{separator})*\\#{speparator}${expr}"
      else
        (0...max).each do |i|
          result << expr
          if i < max - 1
            result << separator
          end
        end
      end
      result
    end

    def self.get_binding
      ExprFunctionsRegex.new.binding
    end

    def self.parse(string)
      eval(string, get_binding)
    end
  end
end