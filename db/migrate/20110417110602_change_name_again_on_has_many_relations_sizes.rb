class ChangeNameAgainOnHasManyRelationsSizes < ActiveRecord::Migration
   def self.up
       rename_table :products_productSizes, :products_product_sizes
   end
   def self.down
       rename_table :products_product_sizes, :products_productSizes
   end
end
