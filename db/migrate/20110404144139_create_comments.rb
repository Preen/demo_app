class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.integer :retailer_id
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
