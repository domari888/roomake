module ApplicationHelper

  def max_width
    if devise_controller?
      'mw-sm'
    else
      'mw-xl'
    end
  end

end
