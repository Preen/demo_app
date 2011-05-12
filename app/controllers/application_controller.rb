class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_user_admin?, :best_price

  def best_price(product, size, amount)
    Price.select("`prices`.*").joins(:retailer, :retailer => :profile).
        where(['product_id=? AND productSize_id=?', product, size]).
        group(:retailer_id).order("SUM((prices.price * #{amount}) + profiles.shippingCost)").limit(1)
  end

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def current_user_admin?
    if current_user
      current_user.admin?
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
