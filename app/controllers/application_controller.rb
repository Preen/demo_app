# encoding: UTF-8
class ApplicationController < ActionController::Base
  before_filter :store_location
  include SessionsHelper

  protect_from_forgery

  helper_method :current_user_admin?, :best_price

  def best_price(product, size, amount)
    Price.select("`prices`.*").joins(:retailer, :retailer => :profile).
        where(['product_id=? AND productSize_id=?', product, size]).
        group(:retailer_id).order("SUM((prices.price * #{amount}) + profiles.shippingCost)").limit(1)
  end

  # Customize the Devise after_sign_in_path_for() for redirecct to previous page after login
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:return_to]
      clear_stored_location
      (store_location.nil?) ? "/" : store_location.to_s
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
      (session[:return_to].nil?) ? "/" : session[:return_to].to_s
  end

  private

  def current_user_admin?
    if current_user
      current_user.admin? 
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
