module HomesHelper
  def user_item_page
    if user_signed_in?
      user_items_path(current_user)
    else
      search_items_path
    end
  end
end
