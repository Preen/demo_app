class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :retailer_id
      t.string :url
      t.integer :shippingCost
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
