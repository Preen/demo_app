class AddRetailerIdToPrice < ActiveRecord::Migration
  def self.up
    add_column :prices, :retailer_id, :integer
  end

  def self.down
    remove_column :prices, :retailer_id
  end
end
