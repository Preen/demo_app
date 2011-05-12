class ChangeTableNameSizesToProductSize < ActiveRecord::Migration
  def self.up
       rename_table :sizes, :productSizes
   end
   def self.down
       rename_table :productSizes, :sizes
   end

end
