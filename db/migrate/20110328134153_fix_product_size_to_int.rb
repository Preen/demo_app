class FixProductSizeToInt < ActiveRecord::Migration
  def self.up
    change_column(:sizes, :productSize, :integer)
  end

  def self.down
  end
end
