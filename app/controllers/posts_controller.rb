class PostsController < ApplicationController
  def index
    @posts = Post.includes(:photos).order(created_at: :desc)
  end

  def show; end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      flash[:notice] = '投稿しました'
    else
      flash[:alert] = 'エラーが発生しました'
    end
    redirect_to posts_path
  end

  def update; end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
