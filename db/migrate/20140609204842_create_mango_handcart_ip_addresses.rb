class CreateMangoHandcartIpAddresses < ActiveRecord::Migration
  def change
    create_table :mango_handcart_ip_addresses do |t|
      t.string :address
      t.string :subnet_mask
      t.belongs_to :handcart, index: true
      t.boolean :blacklisted, default: false

      t.timestamps
    end
  end
end
