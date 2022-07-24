class ApplicationMailer < ActionMailer::Base
  default from: '環境開発用お問い合わせメール <roomake.contact@gmail.com>'
  layout 'mailer'
end
