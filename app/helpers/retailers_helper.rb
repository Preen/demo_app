module RetailersHelper
  def calculate_like(retailer)
    (retailer.votes_for.to_f/(retailer.votes_for + retailer.votes_against)) * 100
  end

  def calculate_dislike(retailer)
    (retailer.votes_against.to_f/(retailer.votes_for + retailer.votes_against)) * 100
  end

  def any_comments?(retailer)
    retailer.comments.any?
  end

  include ActsAsTaggableOn::TagsHelper

end
