module ApplicationHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def admin?
    logged_in? && current_user.admin
  end

  def authenticated_user_filter
    unless logged_in?
      redirect_to root_path
    end
  end

  def admin_user_filter
    unless admin?
      redirect_to root_path
    end
  end
end
