module SessionsHelper

  def deny_access
    store_location
    redirect_to new_user_session_path
  end

  def anyone_signed_in?
    !current_user.nil?
  end

  private

    def store_location
      unless request.fullpath.starts_with? '/users/'
        session[:return_to] = request.fullpath
      end
    end

    def clear_stored_location
      session[:return_to] = nil
    end

end
