class SearchItemsController < ApplicationController
  def index
    flash.now[:alert] = 'キーワードを入力して下さい' if params[:keyword].blank?
    @search_items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
  end
end
