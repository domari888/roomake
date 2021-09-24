class CommentsController < ApplicationController
  before_action :set_post
  def create
    @comment = @post.comments.build(comment_params)
    @comment.save!
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.required(:comment).permit(:content, :user_id, :post_id)
  end
end
