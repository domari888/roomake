ActiveAdmin.register User do
  permit_params :name, :password, :password_confirmation, :email, :age, :address, :profile, :household, :favorite_items, :avatar, :avatar_cache, :terms_of_use

  index do
    selectable_column
    id_column
    column :name
    column :email
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :age, :user, &:age_i18n
      row :address, :user, &:address_i18n
      row :household, :user, &:household_i18n
      row :favorite_items
      row :profile
      row :created_at
      row :updated_at
      row :avatar do
        image_tag(user.avatar.url, class: 'admin-image-preview')
      end
    end
    active_admin_comments
  end

  filter :name
  filter :email
  filter :age, as: :select, collection: User.ages_i18n.invert.transform_values { |v| User.ages[v] }
  filter :address, as: :select
  filter :household, as: :select

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :name
      f.input :age, as: :select, collection: User.ages_i18n.invert
      f.input :address, as: :select, collection: User.addresses_i18n.invert
      f.input :household, as: :select, collection: User.households_i18n.invert
      f.input :favorite_items
      f.input :profile
      f.input :avatar
      f.input :avatar_cache, as: :hidden
      f.input :terms_of_use, as: :hidden, input_html: { value: '1' }
    end
    f.actions
  end
end
