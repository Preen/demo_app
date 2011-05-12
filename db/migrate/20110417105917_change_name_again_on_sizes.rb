class ChangeNameAgainOnSizes < ActiveRecord::Migration
    def self.up
       rename_table :productSizes, :product_sizes
   end
   def self.down
       rename_table :product_sizes, :productSizes
   end
end
