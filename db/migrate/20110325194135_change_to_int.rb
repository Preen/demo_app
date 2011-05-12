class ChangeToInt < ActiveRecord::Migration
  def self.up
    change_column(:prices, :price, :integer)
  end

  def self.down

  end
end
