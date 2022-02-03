class UsersController < ApplicationController
  PER_PAGE = 9
  ITEM_PER_PAGE = 4
  def show
    set_user
    @page = params[:page]
    @posts = @user.post_with_photos.page(params[:post_page]).per(PER_PAGE)
    @likes = @user.like_with_photos.page(params[:like_page]).per(PER_PAGE)
    @marks = @user.mark_with_photos.page(params[:mark_page]).per(PER_PAGE)
    @items = @user.items.order(created_at: :desc).page(params[:item_page]).per(ITEM_PER_PAGE)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
