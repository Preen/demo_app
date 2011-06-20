class AddCachedSlugToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :cached_slug, :string
    add_index  :products, :cached_slug, :unique => true    
  end

  def self.down
    remove_column :products, :cached_slug
  end
end
