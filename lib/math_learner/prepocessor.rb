module MathLearner
  class Prepocessor
    def initialize(text)
      @text = text
    end

    def preprocess
      string = @text.clone
      parenthese_index = 0
      result = ''
      parenthese_index = string.index(/\(|\)/)
      until parenthese_index.nil?
        puts 'index: ' + parenthese_index.to_s + ' -- ' + string[parenthese_index]
        direction = 1
        direction = -1 if string[parenthese_index] == '('
        puts 'dir: ' + direction.to_s

        element = get_element(string, parenthese_index, direction)
        result += string[0...parenthese_index]

        puts 'el: ' + element.to_s

        if string[parenthese_index] == '('
          if element[:separator] == ')' or ( not element[:str].blank? and Function.get_function(element[:str]).nil?)
            result += '*('
          else
            result << '('
          end
        else
          if element[:separator] == '(' or not element[:str].blank?
            result += ')*'
          else
            result << ')'
          end
        end
        string = string[parenthese_index+1..-1]
        parenthese_index = string.index(/\(|\)/)
      end

      result + string
    end

    def get_element(string, index, direction)
      i = index + direction
      #remove useless spaces
      while string[i] == ' '
        i += direction
      end
      start = i
      separators = ' +*/-()'.split('')
      until i < 0 or i >= string.length or separators.include?(string[i])
        i += direction
      end
      hash = {}
      puts 'i: ' + i.to_s
      if start > i
        hash[:str] = string[i+1..start]
      else
        hash[:str] = string[start...i]
      end
      hash[:index] = i
      hash[:separator] = string[i] if i >= 0 and i <= string.length
      hash
    end
  end
end