module ParserOld
  class Element
    attr_accessor :text, :expression, :sub_expressions

    def initialize(text, expression = nil)
      @text = text
      @expression = expression
      @sub_expressions =[]
    end

    def parse(params = nil)
      struct_match = []
      structures = Structure.all
      unless @expression.nil?
        structures = []
        structures << @expression.structure unless @expression.structure.nil?
        @expression.all_children.each do |child|
          if params[:exclude].nil? or not params[:exclude].include?(child)
            structures << child.structure unless child.structure.nil?
          end
        end
      end

      #Find the matching structures
      structures.each do |structure|
        #Will not parse a helper expression unless specificly told so
        if structure.formattable.helper and structure.formattable != @expression
          next
        end
        puts "check #{@text} -- #{structure.formattable} --- #{build_regex(structure.pattern)}"
        if @text.input(build_regex(structure.pattern))
          puts 'match-------------'
          add = true
          struct_match.each do |compare| #Only add the deepest inheritance
            if compare.formattable.is_parent_of?(structure.formattable)
              struct_match.delete(compare)
            elsif  structure.formattable.is_parent_of?(compare.formattable)
              add = false
            end

          end
          struct_match << structure if add
        end
      end

      if struct_match.size > 1
        raise ArgumentError, "Text '#{@text}' is recognized by multiple structure #{struct_match.first} , #{struct_match[1]}" if expression.nil?
      else
        @expression = struct_match.first.formattable
      end
      struct_match.each do |structure|
        subexpressions = []
        structure.pattern.scan(Regex::Argument) do |k|
          expression = extract_expr(k[0])
          raise ArgumentError, "Incorrect format of structure #{structure.pattern}, unknow expression type '#{k}'" if expression[:expression].nil?
          subexpressions << expression[:expression]
        end
        structure.pattern.scan(Regex::Function) do |k|
            ExprFunctionsParser.parse(k)
        end
        #Read the variables
        if subexpressions.size > 0
          regex = Regexp.new structure.pattern.gsub(Regex::Argument, '(.*)')
          @text.scan(regex) do |array|
            array.each_with_index do |sub_expression, index|
              @sub_expressions << Element.new(sub_expression, subexpressions[index]).parse({:exclude => [@expression]}) unless sub_expression.empty?
            end
          end
        end
        regex = Regexp.new structure.pattern.gsub(Regex::Function, '(.*)')

      end
      self
    end


#Build the regex recursively using the given dynamic regex
    def build_regex(string, params = nil)
      result = build_regex_str(string, params)
      Regexp.new "^#{result}$"
    end

    def build_regex_str(string, params=nil)
      result = string.clone
      count = 0
      result.gsub!(Regex::Argument) do |s|
        expr_str = s[2...-1]
        expression = extract_expr(expr_str)
        expr = expression[:expression]

        unless params.nil?
          new_expr_key = nil
          if params.is_a? Hash
            new_expr_key = params[expr.key]
          elsif params.is_a? Array
            new_expr_key = params[count]
          end
          unless new_expr_key.nil?
            new_expr  = Expression.find_by_key(new_expr_key)
            raise ArgumentError, "'#{new_expr_key}' is not a existing expression" if  new_expr.nil?
            expr = new_expr
          end
        end

        count += 1
        build_regex_str(expr.build_pattern, expression[:params])
      end
      result.gsub!(Regex::Function) do |s|
        function = s[2...-1]
        ExprFunctionsRegex.parse(function)
      end
      result
    end

#Read an expression command
    def extract_expr(string)
      result = {}
      first_parenthesis = string.index('(')
      expr_str = string
      unless first_parenthesis.nil?
        expr_str = string[0...first_parenthesis]
        params_str = string[first_parenthesis+1...-1]
        params_array = []
        params_hash = {}
        params_str.split(',').each do |param|
          if param.include?('=>')
            entry = param.split('=>')
            params_hash[entry[0]] = entry[1]
          else
            params_array << param
          end
        end
        if params_hash.size > 0
          result[:params] = params_hash
        else
          result[:params] = params_array
        end
      end
      result[:expression] = Expression.find_by_key(expr_str)
      raise ArgumentError, "'#{expr_str}' is not defined as an expression" if  result[:expression].nil?
      result
    end

  end
  module Regex
    Argument = /\${([a-z_]+(\([a-z_,]+\))?)}/
    Function = /\#{([a-z_]+(\([a-z_,]+\))?)}/
  end
end