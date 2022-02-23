ActiveAdmin.register Comment do
  permit_params :content, :user_id
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

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :user, as: :select, collection: User.order(name: :asc), include_blank: '選択してください'
      f.input :content, hint: '140 文字以下', input_html: { maxlength: 140 }
    end
    f.actions
  end

  remove_filter :post
end
