class MarksController < ApplicationController
  before_action :set_post

  def create
    current_user.marks.create!(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.marks.find_by(post_id: params[:post_id]).destroy!
    redirect_back(fallback_location: root_path)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
