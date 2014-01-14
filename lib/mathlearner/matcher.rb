module MathLearner
  class Matcher
    attr_accessor :mapping

    def initialize()
      @mapping = {}
    end

    #Parse an input using the given pattern
    #@return Matchtree or nil if not matching
    def input(element, pattern)
      #Match is nil if both elemenent have different class(FunctionNode or ElementNode)
      return nil if element.class != pattern.class
      if pattern.is_a? MathLearner::FunctionNode

        #If the function is not the same or different children return fail
        return nil if pattern.function != element.function
        return nil if pattern.children.size != element.children.size


        node = FunctionMatchNode.new(pattern.function)
        if match_children(node, element, pattern)
          return node
        else
          return nil
        end
      elsif pattern.is_a? MathLearner::ElementNode

        if pattern.element.match?(element.element)
          val = @mapping[pattern.value]
          if not val.nil? and val.value != element.value
            return nil
          end
          if val.nil?
            @mapping[pattern.value] = element
          end
          return element
        else
          return nil
        end
      end
    end

    #Helper function
    def match_children(node, element, pattern)

      pattern.children.each_with_index do |pattern_child, index|
        element_child = element.children[index]
        match = input(element_child, pattern_child)
        if match.nil?
          return false
        else
          node.children[pattern_child]=match
        end
      end
      return true
    end

    #Setup a matching of the destination using the previously setup mapping
    def self.transform(destination)
      if destination.is_a? MathLearner::FunctionNode
        node = FunctionMatchNode.new(destination.function)
        destination.children.each do |child|
          trans= transform(child)
          node.children[child] = trans.tree
        end
        return MatchTree.new(node, @mapping)
      elsif destination.is_a? MathLearner::ElementNode
        match = destination.get_value(@mapping)
        raise ArgumentError, "Cannot find value for this variable '#{destination.value}' in mapping #{@mapping}" if match.nil?
        element = destination.clone
        element.value = match
        return MatchTree.new(element, @mapping)
      else
        nil
      end

    end
  end
end