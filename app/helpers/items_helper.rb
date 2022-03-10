module ItemsHelper
  def item_page_title(user)
    current_user.id == user.id ? { title: 'My Item', sub_title: 'マイアイテム' } : { title: 'User Item', sub_title: 'ユーザーアイテム' }
  end
end
