class UsersController < ApplicationController
  PER_PAGE = 9
  def show
    @user = User.find(params[:id])
    @page = params[:page]
    @posts = @user.post_with_photos.page(params[:post_page]).per(PER_PAGE)
    @likes = @user.like_with_photos.page(params[:like_page]).per(PER_PAGE)
    @marks = @user.mark_with_photos.page(params[:mark_page]).per(PER_PAGE)
  end
end
