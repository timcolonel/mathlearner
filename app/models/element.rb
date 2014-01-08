class Element < ActiveRecord::Base
  has_and_belongs_to_many :sub_match, :class_name => Element, :join_table => 'element_match_elements', :association_foreign_key => 'match_id', :foreign_key => 'element_id'

  def match?(subelement)
    subelement == self or sub_match.include?(subelement)

  end
  def to_s
    name
  end
end
