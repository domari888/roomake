class UsersController < ApplicationController
  PER_PAGE = 9
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:photos).order(created_at: :desc).page(params[:post_page]).per(PER_PAGE)
    @likes = @user.liked_posts.includes(:photos).order(created_at: :desc).page(params[:like_page]).per(PER_PAGE)
    @page = params[:page]
  end
end
