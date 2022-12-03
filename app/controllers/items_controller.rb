class ItemsController < ApplicationController
  before_action :set_item, only: :destroy

  PER_PAGE = 20
  def index
    @user = User.find(params[:user_id])
    @items = @user.items.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    @page = params[:page]
  end

  def create
    @item = current_user.items.build(item_params)
    @product_id = params[:product_id]
    if @item.save
      flash.now[:notice] = "#{@item.name} を追加しました"
    else
      flash.now[:alert] = "#{@item.name} を追加することができませんでした"
    end
  end

  def destroy
    item = current_user.items.find(params[:id])
    item.destroy!
    flash.now[:alert] = "#{item.name} を削除しました"
  end

  private

  def set_item
    @item = {
      'id' => params[:id],
      'productName' => params[:name],
      'genreName' => params[:genre],
      'mediumImageUrl' => params[:remote_image_url],
      'productId' => params[:product_id]
    }
  end

  def item_params
    params.require(:item).permit(:name, :genre, :remote_image_url)
  end
end
