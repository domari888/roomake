class HomesController < ApplicationController
  def index
    @posts = Post.includes(:user, :photos, :tags, :categories, :likes, :marks).order(created_at: :desc).limit(2)
  end
end
