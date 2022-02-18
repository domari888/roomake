ActiveAdmin.register Post do
  permit_params :content, :user_id, tag_ids: [], category_ids: [], image: [], photo_ids: []
  includes :user

  form partial: 'form'

  controller do
    def create
      post_params = permitted_params[:post]
      @post = Post.new
      @post_form = PostForm.new(post_params.merge(post: @post))
      if @post_form.save
        redirect_to collection_path, notice: '投稿を作成しました'
      else
        flash.now[:alert] = '内容を確認してください'
        render :new
      end
    end
    
    def update
      post_params = permitted_params[:post]
      @delete_ids = post_params[:photo_ids]
      @post =  Post.find(params[:id])
      @post_form = PostForm.new(post_params.merge(delete_ids: @delete_ids, post: @post))
      if @post_form.save
        redirect_to collection_path, notice: '投稿を編集しました'
      else
        flash.now[:alert] = '内容を確認してください'
        render :edit
      end
    end
  end
end
