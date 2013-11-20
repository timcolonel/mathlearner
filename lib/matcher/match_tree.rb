module Matcher
  class MatchTree
    attr_accessor :tree, :mapping

    def initialize(tree, mapping)
      @tree = tree
      @mapping = mapping
    end

    #Check this data is valid by comparing the mapping to the given one
    def check_valid(hash)
      puts 'checking mapping valid'
      hash.each do |k, v|
        val = @mapping[k]
        puts k.to_s + ' = ' + val.to_s + ' -- ' + v.to_s
        if not val.nil? and val.value != v.value
          raise ArgumentError, "The pattern is not well formed two variable with same name '#{k}' have different value #{v} and #{val}"
        end
      end
      true
    end

    def to_s
      @tree.to_s
    end
  end
end