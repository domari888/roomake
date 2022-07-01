class CommentsController < ApplicationController
  before_action :set_post, on: :create
  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
    else
      render :error_messages
    end
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:id]).destroy!
    flash.now[:alert] = 'コメントを削除しました'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.required(:comment).permit(:content, :user_id, :post_id)
  end
end
