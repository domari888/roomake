class SearchItemsController < ApplicationController
  def index
    return unless params[:keyword]

    @search_items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
  end
end
