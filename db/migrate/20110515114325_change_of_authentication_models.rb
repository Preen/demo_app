class ChangeOfAuthenticationModels < ActiveRecord::Migration
  def self.up
    drop_table :users
    drop_table :authentications
  end

  def self.down
  end
end
