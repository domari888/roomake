require 'rails_helper'

RSpec.describe 'お問い合わせ機能', type: :mailer do
  describe '#user_email' do
    let(:inquiry) { build(:inquiry) }
    let(:mail) { InquiryMailer.user_email(inquiry).deliver_now }

    it 'renders the headers' do
      expect(mail.subject).to eq('【Roomake】お問い合わせを受付いたしました')
      expect(mail.to).to eq([inquiry.email])
      expect(mail.from).to eq(['roomake.contact@gmail.com'])
    end
  end

  describe '#admin_email' do
    let(:inquiry) { build(:inquiry) }
    let(:mail) { InquiryMailer.admin_email(inquiry).deliver_now }

    it 'renders the headers' do
      expect(mail.subject).to eq('【Roomake】お客様よりお問い合わせがありました')
      expect(mail.to).to eq(['roomake.contact@gmail.com'])
      expect(mail.from).to eq(['roomake.contact@gmail.com'])
    end
  end
end
