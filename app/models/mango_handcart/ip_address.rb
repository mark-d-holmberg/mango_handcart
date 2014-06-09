module MangoHandcart
  class IpAddress < ActiveRecord::Base
    belongs_to :handcart, class_name: MangoHandcart.handcart_class.to_s

    validates :address,
      presence: true,
      uniqueness: { case_sensitive: false },
      format: { with: Resolv::IPv4::Regex }

    validates :subnet_mask,
      presence: true,
      format: { with: Resolv::IPv4::Regex }

    scope :blacklisted, -> { where(blacklisted: true) }
    scope :permitted, -> { where.not(blacklisted: true) }
    scope :with_handcart, lambda { |handcart| where(handcart_id: handcart.try(:id)) }
    scope :ordered, -> { order("mango_handcart_ip_addresses.address ASC") }
  end
end
