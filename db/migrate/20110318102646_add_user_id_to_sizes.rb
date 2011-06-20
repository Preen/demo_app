class AddUserIdToSizes < ActiveRecord::Migration
  def self.up
    add_column :sizes, :user_id, :integer
  end

  def self.down
    remove_column :sizes, :user_id
  end
end
