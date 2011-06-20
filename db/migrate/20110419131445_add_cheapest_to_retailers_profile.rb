class AddCheapestToRetailersProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :cheapest, :integer, :default => 0
  end

  def self.down
    remove_column :profiles, :cheapest
  end
end
