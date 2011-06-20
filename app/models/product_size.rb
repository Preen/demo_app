class ProductSize < ActiveRecord::Base
  validates :productSize, :numericality => true
  belongs_to :user
  has_and_belongs_to_many :product
  has_many :price
end
