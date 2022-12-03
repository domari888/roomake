module SearchItemsHelper
  def registered_item?(item_name)
    current_user.items.any? { |item| item.name == item_name }
  end

  def to_item_id(item_name)
    current_user.items.find_by(name: item_name).id
  end
end
