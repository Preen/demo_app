class Size < ActiveRecord::Base
  validates :size, :uniqueness => true, :numericality => true
  belongs_to :user
  belongs_to :product
  has_many :price
end
