module MangoHandcart
  module ActsAsHandcart
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_handcart
        include MangoHandcart::Concerns::Handcarts
      end
    end
  end
end

ActiveRecord::Base.send :include, MangoHandcart::ActsAsHandcart
