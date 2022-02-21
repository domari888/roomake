ActiveAdmin.register Like do
  includes :user
  belongs_to :post
  actions :all, except: %i[edit update]

  index do
    selectable_column
    id_column
    column :user
    column :created_at
    column :updated_at
    actions
  end

  remove_filter :post
end
