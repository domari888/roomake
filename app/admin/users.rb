ActiveAdmin.register User do
  permit_params :name, :password, :password_confirmation, :email, :age, :address, :profile, :household, :favorite_items, :avatar, :avatar_cache, :terms_of_use,
                :remove_avatar

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
  filter :address, as: :select, collection: User.addresses_i18n.invert.transform_values { |v| User.addresses[v] }
  filter :household, as: :select, collection: User.households_i18n.invert.transform_values { |v| User.households[v] }

  form partial: 'form'
end
