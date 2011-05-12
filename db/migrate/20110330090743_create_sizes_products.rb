class CreateSizesProducts< ActiveRecord::Migration
  def self.up
    create_table :products_sizes, :id => false do |t|
      t.references :product
      t.references :size
    end
  end

  def self.down
    drop_table :products_sizes
  end
end
