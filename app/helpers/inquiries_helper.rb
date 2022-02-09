module InquiriesHelper
  def footer_display
    if controller_name == 'homes'
      'footer-before-signing' unless user_signed_in?
    else
      'd-sm-block d-none'
    end
  end
end
