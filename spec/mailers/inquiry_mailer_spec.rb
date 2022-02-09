require 'rails_helper'

RSpec.describe InquiryMailer, type: :mailer do
  describe 'user_email' do
    let(:mail) { InquiryMailer.user_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('User email')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end

  describe 'admin_email' do
    let(:mail) { InquiryMailer.admin_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Admin email')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
