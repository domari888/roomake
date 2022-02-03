# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/inquiry_mailer/user_email
  def user_email
    InquiryMailer.user_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/inquiry_mailer/admin_email
  def admin_email
    InquiryMailer.admin_email
  end

end
