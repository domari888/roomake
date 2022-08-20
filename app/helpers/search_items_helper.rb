module SearchItemsHelper
  def registered_item?(item_name)
    current_user.items.any? { |item| item.name == item_name }
  end
end
