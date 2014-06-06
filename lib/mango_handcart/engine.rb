module MangoHandcart
  class Engine < ::Rails::Engine

    config.generators do |g|
      g.hidden_namespaces << :test_unit << :erb
      g.test_framework :rspec, fixture: false, view_specs: false
      g.integration_tool :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.template_engine :haml
      g.stylesheet_engine :scss
      g.assets false
      g.helper false
    end


    # Pull in the JSON file
    config.after_initialize do
      if File.exists?(File.join(Rails.root, 'config', 'mango_handcart_constraints.json'))
        # Don't load the app's config file when we're testing the gem
        config_file = File.join(Rails.root, 'config', 'mango_handcart_constraints.json')
      elsif File.exists?(File.join(MangoHandcart::Engine.root, 'config', 'mango_handcart_constraints.json'))
        # But default to using the gem config if one can't be found
        config_file = File.join(MangoHandcart::Engine.root, 'config', 'mango_handcart_constraints.json')
      end
      if config_file
        my_config_file = JSON.parse(File.read(config_file))
        CONFIG = my_config_file.fetch(Rails.env, {})
        CONFIG.symbolize_keys!
      end
    end

    isolate_namespace MangoHandcart
  end
end
