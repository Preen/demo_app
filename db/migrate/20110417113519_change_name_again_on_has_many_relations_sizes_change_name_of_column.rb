class ChangeNameAgainOnHasManyRelationsSizesChangeNameOfColumn < ActiveRecord::Migration
  def self.up
    rename_column :product_sizes_products, :size_id, :product_size_id
  end

  def self.down
    rename_column :product_sizes_products, :product_size_id, :size_id
  end
end
