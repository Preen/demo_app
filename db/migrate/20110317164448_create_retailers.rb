class CreateRetailers < ActiveRecord::Migration
  def self.up
    create_table :retailers do |t|
      t.string :title
      t.datetime :published_at
      t.timestamps
    end
  end

  def self.down
    drop_table :retailers
  end
end
