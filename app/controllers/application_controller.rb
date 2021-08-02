class ApplicationController < ActionController::Base
  before_action :authenticate_user!, if: :controller_name?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def controller_name?
    unless controller_name == 'homes'
      true
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:age])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:household])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:age])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:household])
    devise_parameter_sanitizer.permit(:account_update, keys: [:favorite_items])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile])
  end
end
