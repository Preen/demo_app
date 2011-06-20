class AddSizeIdToPrice < ActiveRecord::Migration
  def self.up
    add_column :prices, :size_id, :integer
  end

  def self.down
    remove_column :prices, :size_id
  end
end
