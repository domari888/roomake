module UsersHelper
  def tab_name(user)
    current_user.id == user.id ? 'marked' : 'item'
  end
end
