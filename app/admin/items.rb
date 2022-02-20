ActiveAdmin.register Item do
  permit_params :name, :genre, :image, :user_id, :keyword
  includes :user
  actions :all, except: %i[edit update]

  index do
    selectable_column
    id_column
    column :name
    column :user
    column :created_at
    column :updated_at
    actions
  end
end
