class ChangeNameAgainOnHasManyRelationsSizesNowFuckingWork < ActiveRecord::Migration
   def self.up
       rename_table :products_product_sizes, :product_sizes_products
   end
   def self.down
       rename_table :product_sizes_products, :products_product_sizes
   end
end
