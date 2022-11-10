module HomesHelper
  def function_page(title)
    case title
    when 'Time Line'
      posts_path
    when 'My Item'
      user_signed_in? ? user_items_path(current_user) : search_items_path
    when 'Know How'
      know_hows_path
    when 'Data'
      graphs_path
    end
  end
end
