class Comment < ActiveRecord::Base
  belongs_to :retailer
  belongs_to :product
  belongs_to :user

  default_scope order('comments.created_at DESC')

end
