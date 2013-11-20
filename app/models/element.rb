class Element < ActiveRecord::Base
  has_and_belongs_to_many :sub_match, :class_name => Element, :join_table => 'element_match_elements', :association_foreign_key => 'match_id', :foreign_key => 'element_id'

  def match?(subelement)
    puts 'sel: ' + to_s
    puts 'sub: ' + subelement.to_s
    puts 'list: ' + sub_match.all.to_s
    subelement == self or sub_match.include?(subelement)

  end
  def to_s
    name
  end
end
