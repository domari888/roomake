class InquiryMailer < ApplicationMailer
  ADMIN_EMAIL = 'roomake.contact@gmail.com'.freeze

  def user_email(inquiry)
    @inquiry = inquiry
    subject = '【Roomake】お問い合わせを受付いたしました'
    mail(
      to: inquiry.email,
      subject: subject
    )
  end

  def admin_email(inquiry)
    @inquiry = inquiry
    subject = '【Roomake】お客様よりお問い合わせがありました'
    mail(
      to: ADMIN_EMAIL,
      subject: subject
    )
  end
end
