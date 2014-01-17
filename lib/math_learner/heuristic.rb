module MathLearner

  module HeuristicCoefficient
    DELTA_FUNCTION = 1
    DELTA_CHILD = 1
    CHILD = 1
    SAME_FUNCTION = 1
    SAME_ELEMENT = 0.1
    SAME_ELEMENT_VALUE = 2
  end

  class Heuristic
    include HeuristicCoefficient

    def self.compute(current, final, can_check_element = true)

      result = 0
      result += compute_function(current, final)
      if current.function == final.function
        result += SAME_FUNCTION
        can_check_element = false
      end
      if can_check_element
        result += check_element(current, final)
      end

      result += compute_total_element(current, final)

      c_children_size = 0
      f_children_size = 0
      if current.is_function?
        c_children_size = current.children.size
      end
      if final.is_function?
        f_children_size = final.children.size
        final.children.each_with_index do |child, i|
          if i >= c_children_size
            break
          end
          result += compute(current.children[i], child, can_check_element) / f_children_size * CHILD
        end
      end
      if c_children_size != f_children_size
        result -= (f_children_size-c_children_size).abs * DELTA_CHILD
      else
        result += 1
      end

      result
    end

    def self.compute_function(current, final)
      result = 0
      current_functions = {}
      final_functions = {}
      if current.is_a? MathLearner::FunctionNode
        current_functions = current.functions_count
      end
      if final.is_a? MathLearner::FunctionNode
        final_functions = final.functions_count
      end
      result += compute_difference(current_functions, final_functions, DELTA_FUNCTION)
      result
    end

    def self.compute_difference(hash, hash_final, coef)
      result = 0

      #TODO handle function in current but not in final
      hash_final.each do |f, f_count|
        c_count = hash[f]
        c_count ||= 0
        value = 1 - ((f_count - c_count).abs / f_count)
        result += value * coef
      end
      result
    end

    def self.check_element(current, final)
      result = 0
      if current.is_element? and final.is_element?
        result += SAME_ELEMENT if current.element == final.element
        result += SAME_ELEMENT_VALUE if current.value == final.value
      end
      result
    end

    def self.compute_total_element(current, final)
      result = 0
      current_elements = {}
      final_elements = {}
      if current.is_a? MathLearner::FunctionNode
        current_elements = current.elements_count
      end
      if final.is_a? MathLearner::FunctionNode
        final_elements = final.elements_count
      end
      result += compute_difference(current_elements, final_elements, DELTA_FUNCTION)
      result
    end
  end

end
