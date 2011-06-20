class AddCachedSlugToRetailers < ActiveRecord::Migration
  def self.up
    add_column :retailers, :cached_slug, :string
    add_index  :retailers, :cached_slug, :unique => true
  end

  def self.down
    remove_column :retailers, :cached_slug  
  end
end
