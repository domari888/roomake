class UsersController < ApplicationController
  PER_PAGE = 9
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:photos).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    @page = params[:page]
  end
end
