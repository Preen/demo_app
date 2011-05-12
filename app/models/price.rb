class Price < ActiveRecord::Base

  validates :price, :numericality => true
  belongs_to :retailer
  belongs_to :product
  belongs_to :productSize
  belongs_to :user

end
