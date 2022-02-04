module ApplicationHelper
  def max_width
    if devise_controller? || controller_name == 'inquiries'
      'mw-sm'
    else
      'mw-xl'
    end
  end
end
