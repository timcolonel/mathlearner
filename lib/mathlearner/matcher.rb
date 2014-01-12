module MathLearner
  class Matcher
    attr_accessor :mapping

    def initialize()
      @mapping = {}
    end

    def match(element, pattern)
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

    def match_children(node, element, pattern)

      pattern.children.each_with_index do |pattern_child, index|
        element_child = element.children[index]
        match = match(element_child, pattern_child)
        if match.nil?
          return false
        else
          node.children[pattern_child]=match
        end
      end
      return true
    end

    #Return matchdata
    def self.transform(destination, matchmapping)
      if destination.is_a? MathLearner::FunctionNode
        node = FunctionMatchNode.new(destination.function)
        destination.children.each do |child|
          trans= transform(child, matchmapping)
          node.children[child] = trans.tree
        end
        return MatchTree.new(node, matchmapping)
      elsif destination.is_a? MathLearner::ElementNode
        match = destination.extract_map(matchmapping)
        raise ArgumentError, "Cannot find value for this variable '#{destination.value}' in mapping #{matchmapping}" if match.nil?
        element = destination.clone
        element.value = match
        return MatchTree.new(element, matchmapping)
      else
        nil
      end

    end

    def compute_similarity(current, final)

    end
  end
end