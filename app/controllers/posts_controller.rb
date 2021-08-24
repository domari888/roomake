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

  def update
    post = current_user.posts.find(params[:id])
    post_form = PostForm.new(post_params.merge(current_user_id: current_user.id, post: post))
    if post_form.save
      flash[:notice] = '投稿を編集しました'
    else
      flash[:alert] = '編集できませんでした'
    end
    redirect_to post
  end

  private

  def post_params
    params.require(:post_form).permit(:content, :image)
  end
end
