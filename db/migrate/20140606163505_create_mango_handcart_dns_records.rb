class CreateMangoHandcartDnsRecords < ActiveRecord::Migration
  def change
    create_table :mango_handcart_dns_records do |t|
      t.string :name
      t.string :subdomain
      t.string :domain
      t.integer :tld_size
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
