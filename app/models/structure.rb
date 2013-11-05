class Structure < ActiveRecord::Base
  belongs_to :formattable, :polymorphic => true


  def to_s
    pattern.to_s
  end

end
