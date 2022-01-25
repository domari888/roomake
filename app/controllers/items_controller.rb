class ItemsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @items = user.items.order(created_at: :desc)
  end
end
