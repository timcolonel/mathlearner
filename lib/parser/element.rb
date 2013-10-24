module Parser
  class Element
    attr_accessor :text, :expression, :sub_expressions

    def initialize(text, expression = nil)
      @text = text
      @expression = expression
      @sub_expressions =[]
    end

    def parse
      struct_match = []
      structures = Structure.all
      unless @expression.nil?
        structures = @expression.formats
        @expression.all_children.each do |child|
          structures += child.formats
        end
      end
      puts "text: #{@text}"
      structures.each do |structure|
        #Will not parse a helper expression unless specificly told so
        if structure.formattable.helper and structure.formattable != @expression
          next
        end
        if @text.match(build_regex(structure.pattern))
          add = true
          struct_match.each do |compare| #Only add the deepest inheritance
            puts "compare: #{compare.formattable} - #{structure.formattable}"
            if structure.formattable.parent == compare.formattable
              puts 'remove compare'
              puts struct_match
              struct_match.delete(compare)
              puts struct_match.size
            elsif compare.formattable.parent == structure.formattable
              add = false
            end

          end
          puts 'add: ' + add.to_s
          struct_match << structure if add
        end
      end
      puts 'done: ' + struct_match.size.to_s
      if struct_match.size > 1
        raise ArgumentError, "Text is recognized by multiple structure #{struct_match.first} , #{struct_match[1]}" if expression.nil?
      else
        @expression = struct_match.first.formattable
        puts 'exp: ' + @expression.to_s
      end
      struct_match.each do |structure|

        subexpressions = []
        structure.pattern.scan(Regex::Argument) do |k|
          expression = Expression.find_by_key(k)
          raise ArgumentError, "Incorrect format of structure #{structure.pattern}, unknow expression type '#{k}'" if expression.nil?
          subexpressions << expression
        end
        puts 'struc: ' + subexpressions.size.to_s + ' in ' + @expression.to_s
        regex = Regexp.new structure.pattern.gsub(Regex::Argument, '(.*)')
        if subexpressions.size > 0
          puts 'size: ' + subexpressions.size.to_s
          @text.scan(regex) do |array|
            puts 'size2: ' + array.size.to_s
            array.each_with_index do |sub_expression, index|
              puts "sub text: #{sub_expression} from #{@text} in #{@expression} is empty #{sub_expression.empty?}"
              @sub_expressions << Element.new(sub_expression, subexpressions[index]).parse unless sub_expression.empty?
            end
          end
        end
      end
      self
    end

    def build_regex(string)
      result = string.clone
      tmp = ''
      while tmp != result
        tmp = result.clone
        puts 'lol: ' + result
        result.gsub!(Regex::Argument) do |s|
          puts 'replacing: ' + s
          expression = Expression.find_by_key(s[2...-1])
          raise ArgumentError, "Incorrect format of structure #{structure.pattern}, unknow expression type '#{s}'" if expression.nil?
          struct = expression.formats.first
          raise ArgumentError, "Expression '#{expression.name}' has no format, add at least one" if struct.nil?

          struct.pattern
        end
        puts "#{tmp} - #{result}"
      end
      puts 'Regex builded: ' + result
      Regexp.new "^#{result}$"
    end

  end

  module Regex
    Argument = /\${([a-z_]+)}/
  end
end