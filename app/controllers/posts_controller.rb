class PostsController < ApplicationController
  def index
    @posts = Post.includes(:photos).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    post = PostForm.new(post_params.merge(current_user_id: current_user.id))
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
    params.require(:post_form).permit(:content, :image)
  end
end
