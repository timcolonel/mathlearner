class Algorithm < ActiveRecord::Base
  has_many :steps, :class_name => Step
  has_one :input, -> { where parent_id: nil }, :class_name => Step
  has_many :outputs, -> { where output: true }, :class_name => Step
end
