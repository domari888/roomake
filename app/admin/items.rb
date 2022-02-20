ActiveAdmin.register Item do
  includes :user
  actions :all, except: %i[edit update]

  form partial: 'form'

  controller do
    def create
      user = User.find(params[:user_id])
      if user.items.find_by(name: params[:name]).nil?
        item = user.items.build(name: params[:name], genre: params[:genre], image: params[:image])
        if item.save
          redirect_to admin_item_path(item), notice: "#{params[:name]} をマイアイテムに追加しました"
        else
          redirect_back(fallback_location: collection_path, flash: { error: "#{params[:name]} を追加することができませんでした" })
        end
      else
        redirect_back(fallback_location: collection_path, flash: { error: "#{params[:name]} は既に登録されています" })
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :user
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :genre
      row :image do
        image_tag(item.image)
      end
      row :user
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
