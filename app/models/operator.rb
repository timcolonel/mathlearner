class Operator < ActiveRecord::Base
  def to_s
    display_name
  end
end
