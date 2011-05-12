class AddBoleanValuesToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :creditCard, :boolean
    add_column :profiles, :invoice, :boolean
    add_column :profiles, :prepaid, :boolean
    add_column :profiles, :internetBank, :boolean
  end

  def self.down
    remove_column :profiles, :creditCard, :boolean
    remove_column :profiles, :invoice, :boolean
    remove_column :profiles, :prepaid, :boolean
    remove_column :profiles, :internetBank, :boolean
  end
end
