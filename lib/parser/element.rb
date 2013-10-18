module Parser
  class Element
    attr_accessor :text, :expression, :children

    def initialize(text)
      @text = text
    end

    def parse
      struct_match = []
      Structure.all.each do |structure|
        if @text.match(build_regex(structure.pattern))
          add = true
          struct_match.each do |compare| #Only add the deepest inheritance
            if structure.formattable.parent == compare.formattable
              struct_match.delete(compare)
            elsif compare.formattable.parent == structure.formattable
              add = false
            end

          end
          struct_match << structure if add
        end
      end
      struct_match.each do |structure|
        subexpressions = []
        structure.pattern.scan(Regex::Argument) do |k|
          expression = Expression.find_by_key(k)
          raise ArgumentError, "Incorrect format of structure #{structure.pattern}, unknow expression type '#{k}'" if expression.nil?
          subexpressions << expression
        end

        regex = Regexp.new structure.pattern.gsub(Regex::Argument, '(.*)')
        puts 'regex: ' + structure.pattern.gsub(Regex::Argument, '(.*)')
        text.scan(regex) do |exp|
          puts 'exp: ' + exp.to_s
        end
      end
      struct_match
    end

    def build_regex(string)
      result = string.clone
      tmp = ''
      while tmp != result
        tmp = result
        puts 'lol: ' + result
        result.gsub!(Regex::Argument) do |s|
          puts 'replacing: ' + s
          expression = Expression.find_by_key(s[2...-1])
          raise ArgumentError, "Incorrect format of structure #{structure.pattern}, unknow expression type '#{s}'" if expression.nil?
          struct = expression.formats.first
          raise ArgumentError, "Expression '#{expression.name}' has no format, add at least one" if struct.nil?

          struct.pattern
        end
      end
      Regexp.new "^#{result}$"
    end

  end

  module Regex
    Argument = /\${([a-z_]+)}/
  end
end