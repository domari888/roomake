module ApplicationHelper
  def max_width
    if devise_controller? || controller_name == 'inquiries'
      'mw-sm'
    elsif controller_name == 'homes'
      'px-0'
    else
      'mw-xl'
    end
  end
end
