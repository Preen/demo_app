class AddProductUrlToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :productURL, :string
  end

  def self.down
    remove_column :profiles, :productURL
  end
end
