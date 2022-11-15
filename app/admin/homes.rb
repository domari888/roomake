ActiveAdmin.register Home do
  permit_params :title, :subtitle, :image, :content, :image_cache
  config.sort_order = 'id_asc'

  # 新規作成・削除を制限
  actions :all, except: [:new, :destroy]

  index do
    selectable_column
    id_column
    column :title
    column :subtitle
    column :content
    actions
  end

  show do
    attributes_table do
      row :image do |home|
        image_tag(home.image.url, size: '100x100')
      end
      row :title
      row :subtitle
      row :content
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  filter :title
  filter :subtitle
  filter :content

  form partial: 'form'
end
