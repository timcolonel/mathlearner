class Expression < ActiveRecord::Base
  belongs_to :parent, :class_name => Expression
  validates_uniqueness_of :name
  validates_uniqueness_of :key

  has_one :structure, :class_name => Structure, :as => 'formattable'
  has_many :children, :class_name => Expression, :foreign_key => :parent_id

  accepts_nested_attributes_for :structure
  
  def to_s
    name
  end

  def all_children
    result = []
    children.each do |child|
      result << child
      result+= child.all_children
    end
    result
  end

  def is_parent_of?(expression)
    parent = expression.parent
    until parent.nil?
      return true if parent == self
      parent = parent.parent
    end
    return false
  end

  def build_pattern
    if structure.nil?
      if children.size == 0
        raise ArgumentError, "Expression '#{expression[:expression].name}' has no format or children, add at least one"
      else
        "(#{children.map { |child| "(#{child.build_pattern})" }.join('|')})"
      end
    else
      structure.pattern
    end
  end
end
