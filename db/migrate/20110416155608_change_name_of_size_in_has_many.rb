class ChangeNameOfSizeInHasMany < ActiveRecord::Migration
   def self.up
       rename_table :products_sizes, :products_productSizes
   end
   def self.down
       rename_table :products_productSizes, :products_sizes
   end
end
