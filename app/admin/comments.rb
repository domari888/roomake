ActiveAdmin.register Comment do
  belongs_to :post
  includes :user

  index do
    selectable_column
    id_column
    column :content
    column :user
    column :created_at
    column :updated_at
    actions
  end

  remove_filter :post
end
