class Company < ActiveRecord::Base
  acts_as_handcart

  scope :ordered, -> { order("companies.name ASC") }


  def to_s
    name
  end
end
