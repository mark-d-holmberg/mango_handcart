module MangoHandcart
  # The custom rails generator
  module Generators
    # Generates the default configuration file for customizing the MangoHandcart gem.
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc "Copies Mango Handcart's configuration file to your application's initializer directory."

      # Copies the template file over.
      def copy_config_file
        template 'mango_handcart_config.rb', 'config/initializers/mango_handcart.rb'
      end
    end
  end
end
