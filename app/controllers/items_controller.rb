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
    if @item.save
      redirect_to user_items_path, notice: "#{@item.name} をマイアイテムに追加しました"
    else
      redirect_to user_items_path, alert: 'アイテムを追加することができませんでした'
    end
  end

  def destroy
    @item.destroy!
    flash.now[:alert] = "#{@item.name} を削除しました"
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :genre, :remote_image_url)
  end
end
