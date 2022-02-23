ActiveAdmin.register_page 'search_results' do
  menu false

  action_item :view, only: :index do
    link_to 'アイテムを検索する', new_admin_item_path
  end

  controller do
    def index
      return unless params[:keyword]

      @search_items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
    end
  end

  content title: '検索結果' do
    render partial: 'index', locals: { keyword: params[:keyword], search_items: search_items } if params[:keyword].present?
  end
end
