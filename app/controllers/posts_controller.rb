class PostsController < ApplicationController
  before_action :set_post, only: %i[update destroy]

  def index
    @posts = Post.includes(:photos).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def create
    @post = Post.new
    post_form = PostForm.new(post_params.merge(current_user_id: current_user.id, post: @post))
    if post_form.save
      redirect_to posts_path, notice: '投稿しました'
    else
      redirect_to posts_path, alert: 'エラーが発生しました'
    end
  end

  def update
    post_form = PostForm.new(post_params.merge(current_user_id: current_user.id, post: @post))
    if post_form.save
      redirect_to @post, notice: '投稿を編集しました'
    else
      redirect_to @post, alert: '編集できませんでした'
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, alert: '削除しました'
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post_form).permit(:content, image: [])
  end
end
