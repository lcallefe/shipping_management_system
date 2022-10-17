class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:index, :edit, :show, :create, :new]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  helper_method :admin
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
  end

  def admin  
    current_user.admin?
  end
end
