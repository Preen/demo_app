class FixSizeColumnName < ActiveRecord::Migration
  def self.up
    rename_column :sizes, :size, :productSize
  end

  def self.down
    rename_column :sizes, :productSize, :size
  end
end
