class ApplicationController < ActionController::Base
  before_action :authenticate_user!, if: :controller_name?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def controller_name?
    true unless controller_name == 'homes' || controller_name == 'inquiries' || controller_name == 'pages'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :avatar_cache, :name, :age, :address, :household, :agreement])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :avatar_cache, :name, :age, :address, :household, :favorite_items, :profile])
  end

  def set_search
    @q = Post.ransack(params[:q])
  end
end
