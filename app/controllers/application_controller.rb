class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters,if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_Sign_up_for(resource)
    if sign_up
     flash[:notice] = "Welcome! You are successfully signed up!"
    end
  end




  def after_sign_out_path_for(resource_or_scope)
    # if resource_or_scope == :user
    #   new_user_session_path
    # elsif resource_or_scope == :admin
    #   new_admin_session_path
    # else
      root_path
    # end
  end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up,keys: [:name])
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
