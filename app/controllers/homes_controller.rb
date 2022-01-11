class HomesController < ApplicationController
  def index
    @posts = Post.includes(:user, :photos).order(created_at: :desc).limit(4)
  end
end
