module MangoHandcart::Concerns::Handcarts
  extend ActiveSupport::Concern

  included do
    belongs_to :dns_record, class_name: MangoHandcart.dns_record_class.to_s
    has_many :ip_addresses, dependent: :destroy, class_name: "MangoHandcart::IpAddress", foreign_key: "handcart_id"

    # Nuke the dns_record
    before_destroy { |handcart| handcart.dns_record.destroy if handcart.dns_record.present? }
  end

  module ClassMethods
    # Try to formulate a path to view the handcart show page
    def handcart_show_path(handcart)
      if MangoHandcart.handcart_show_path.present?
        # Load it straight from the config
        "/#{MangoHandcart.handcart_show_path}/#{handcart.to_param}"
      else
        if Rails.application.routes.url_helpers.respond_to?("#{MangoHandcart.handcart_class.model_name.singular}_path".to_sym)
          # Is there one already defined
          Rails.application.routes.url_helpers.send("#{MangoHandcart.handcart_class.model_name.singular}_path", handcart.to_param)
        else
          # Shot in the dark
          "/#{MangoHandcart.handcart_class.model_name.route_key}/#{handcart.to_param}"
        end
      end
    end
  end

end
