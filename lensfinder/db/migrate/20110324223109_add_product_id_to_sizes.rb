class AddProductIdToSizes < ActiveRecord::Migration
  def self.up
    add_column :sizes, :product_id, :integer
  end

  def self.down
    remove_column :sizes, :product_id
  end
end
