class ChangeNameOfPricesSizeFuckofff < ActiveRecord::Migration
    def self.up
    rename_column :prices, :product_size_id, :productSize_id
  end

  def self.down
    rename_column :prices, :productSize_id, :product_size_id
  end
end
