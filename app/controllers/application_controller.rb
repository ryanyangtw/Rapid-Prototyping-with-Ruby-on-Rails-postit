class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user, :logged_in?
  
  def logged_in?
    #current_user.present?
    !!current_user
  end


  def current_user
    # Memorization. we will guarente the query just be hitted on e time
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !logged_in?
      flash[:error] = "Must be login to do that"
      redirect_to root_path
    end
  end




end
