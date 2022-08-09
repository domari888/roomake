class PostsController < ApplicationController
  before_action :set_post, only: %i[update destroy]
  PER_PAGE = 20

  def index
    @posts = @q.result.includes(:user, :photos, :tags, :categories, :likes, :marks).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    @page = params[:page]
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    gon.edit_content = @post.content
    gon.edit_photos = @post.photos
    gon.edit_tags = @post.tags
    gon.edit_categories = @post.categories
  end

  def create
    @post = Post.new
    @post_form = PostForm.new(post_params.merge(user_id: current_user.id, post: @post))
    if @post_form.save
      flash[:notice] = '投稿しました'
      # フォーマットが js のため JavaScript を使用してページ遷移
      render js: "window.location.replace('#{posts_path}');"
    else
      render :create_error_messages
    end
  end

  def update
    @post_form = PostForm.new(post_params.merge(user_id: current_user.id, post: @post))
    if @post_form.save
      flash[:notice] = '投稿を編集しました'
      # フォーマットが js のため JavaScript を使用してページ遷移
      render js: "window.location.replace('#{post_path(@post)}');"
    else
      render :update_error_messages
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
    params.require(:post_form).permit(:content, images: [], tag_ids: [], category_ids: [], delete_ids: [])
  end
end
