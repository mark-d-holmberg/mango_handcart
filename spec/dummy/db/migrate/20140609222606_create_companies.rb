class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.belongs_to :dns_record, index: true
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
