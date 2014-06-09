class Company < ActiveRecord::Base
  acts_as_handcart

  def to_s
    name
  end
end
