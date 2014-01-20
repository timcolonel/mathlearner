module MathLearner
  class Tree
    attr_accessor :root, :cursor, :priority, :last_operator

    def initialize(text = nil, priority = 0)
      @text = text
      @root = nil
      @cursor = 0
      @priority = priority
      @last_operator = nil
    end

    def parse
      #next_node(0)
      element = next_element
      #Take care of -1, 5*-3,..
      if element.is_a? Operator and element.single_use?
        node = FunctionNode.new
        node.function = element
        node.children <<  next_element
        element =  node
      end
      operator = next_element
      if operator.nil?
        @root = element
        return @root
      end
      if operator.priority < priority
        @root = element
        @last_operator = operator
        return @root
      else
        current_operator = operator
        current_node = FunctionNode.new
        @root = current_node
        current_node.function = operator
        current_node.children << element
        begin
          tree = Tree.new(@text[@cursor..-1], current_operator.priority)


          current_node.children << tree.parse
          @cursor += tree.cursor
          if tree.last_operator.nil?
            return current_node
          end
          if tree.last_operator.priority < priority
            @last_operator = tree.last_operator
            return current_node
          else
            tmp_node = current_node
            current_node = FunctionNode.new
            current_node.function = tree.last_operator
            current_node.children << tmp_node
          end
        end while true
      end
      @root
    end

    def next_node(priority)
      element = next_element
      operator = next_element

      if operator.nil? #If the operator is nil mean its the end of reading for this tree
        node = element
        @root = node if @root.nil?
        node
      else
        node = FunctionNode.new
        @root = node if @root.nil?
        if operator.priority >= priority
          node.children << element
          node.function = operator
          next_node = next_node(operator.priority)
          node.children << next_node
          node
        else
          node.children << @root
          node.function = operator
          next_node = next_node(operator.priority)
          node.children << next_node
          @root = node
          element
        end

      end
    end

    #Return a node or an operator
    def next_element
      ignore_whitespace
      string = @text[@cursor..-1]

      return nil if string.nil? or string.empty?
      #If we have a left parenthese then we create an other tree with the content of the parenthese
      if string[0] == '('
        sub_tree = Tree.new(string[1..-1])
        sub_tree.parse
        @cursor += sub_tree.cursor + 1
        return sub_tree.root
      end
      #if we have a closing parentheses it's the end of the word(it's been preporcess before so this imply we have
      # recusively made a new tree with the inside of the parentheses)
      if string[0] == ')'
        @cursor += 1
        return nil
      end
      operator = get_operator(string)
      unless operator.nil?
        @cursor += 1
        return operator
      end
      index = 0
      until index >= string.length or string[index] == ')' or string[index].match(Regex::operator)
        index += 1
      end
      @cursor += index

      key = string[0...index]
      function = get_function(key)
      unless function.nil?
        node = FunctionNode.new(function)
        return node
      end

      element = get_element(string)
      unless element.nil?
        node = ElementNode.new(element, key)
        return node
      end
      throw ArgumentError, "Unkown element: #{key}"
    end

    def get_operator(string)
      Operator.all.each do |operator|
        return operator if string.match(Regexp.new("^#{operator.pattern}"))
      end
      nil
    end

    def get_function(string)
      Function.all.each do |function|
        return function if string.match(Regexp.new(function.pattern))
      end
      nil
    end

    def get_element(string)
      Element.all.each do |element|
        return element if string.match(Regexp.new "^#{element.pattern}")
      end
    end

    def ignore_whitespace
      while @text[@cursor] == ' '
        @cursor +=1
      end
    end
  end

  class Regex
    def self.operator
      Regexp.new(Operator.all.map { |x| x.pattern }.join('|'))
    end
  end
end