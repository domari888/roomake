module UsersHelper
  def tab_name(user)
    current_user.id == user.id ? 'marked' : 'item'
  end

  def page_title(user)
    current_user.id == user.id ? { title: 'My Page', sub_title: 'マイページ' } : { title: 'User Details', sub_title: 'ユーザー詳細' }
  end
end
