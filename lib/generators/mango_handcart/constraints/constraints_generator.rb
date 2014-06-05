class MangoHandcart::ConstraintsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  def copy_config_file
    template 'mango_handcart_constraints.json', 'config/mango_handcart_constraints.json'
  end
end
