class Expression < ActiveRecord::Base
  belongs_to :parent, :class_name => Expression
  validates_uniqueness_of :name
  validates_uniqueness_of :key

  has_many :formats, :class_name => Structure, :as => 'formattable'
  has_many :children, :class_name => Expression, :foreign_key => :parent_id

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
end
