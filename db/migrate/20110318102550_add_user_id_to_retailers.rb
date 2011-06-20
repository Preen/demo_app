class AddUserIdToRetailers < ActiveRecord::Migration
  def self.up
    add_column :retailers, :user_id, :integer
  end

  def self.down
    remove_column :retailers, :user_id
  end
end
