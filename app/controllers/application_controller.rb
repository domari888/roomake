class ApplicationController < ActionController::Base
  before_action :authenticate_user!, if: :controller_name?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def controller_name?
    true unless controller_name == 'homes'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avater, :name, :age, :address, :household])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avater, :name, :age, :address, :household, :favorite_items, :profile])
  end

  def set_search
    @q = Post.ransack(params[:q])
  end
end
