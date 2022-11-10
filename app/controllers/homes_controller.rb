class HomesController < ApplicationController
  def index
    @homes = Home.order(id: :asc)
    @posts = Post.includes(:user, :photos).order(created_at: :desc).limit(4)
  end
end
