class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :birthday, :name])
  end

  protected

  def after_sign_in_path_for(resource)
    homes_path
  end

end
