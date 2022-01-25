class ItemsController < ApplicationController
  before_action :registered_item?, only: %i[create]

  def index
    user = User.find(params[:user_id])
    @items = user.items.order(created_at: :desc)
  end

  def create
    @item = current_user.items.build(name: params[:name], genre: params[:genre], image: params[:image])
    if @item.save
      redirect_to user_items_path(current_user), notice: "#{params[:name]} をマイアイテムに追加しました"
    else
      flash[:alert] = 'アイテムを追加することができませんでした'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def registered_item?
    return unless current_user.items.find_by(name: params[:name])

    flash[:alert] = 'アイテムは既に登録されています'
    redirect_back(fallback_location: root_path)
  end
end
