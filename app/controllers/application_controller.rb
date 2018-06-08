class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  check_authorization unless: :devise_controller?
  
  #catching access denied exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to user_root_path
  end

  def after_sign_in_path_for(resource)
    if params[:page_referrer].present?
      params[:page_referrer]
    else
      super
    end
  end
    
end
