class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:index, :edit, :show, :create, :new]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
  end

  def admin  
    if !current_user.admin?
      redirect_to root_path, notice: 'Operação não permitida'   
    end
  end
end
