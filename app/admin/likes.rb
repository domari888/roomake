ActiveAdmin.register Like do
  permit_params :user_id
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

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :user, as: :select, collection: User.order(name: :asc), include_blank: '選択してください'
    end
    actions
  end

  remove_filter :post
end
