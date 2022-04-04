require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'バリデーション' do
    subject { admin_user.valid? }

    context 'データが条件を満たすとき' do
      let(:admin_user) { build(:admin_user) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    context 'email が空のとき' do
      let(:admin_user) { build(:admin_user, email: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(admin_user.errors.messages[:email]).to include 'を入力してください'
      end
    end

    context 'email がすでに存在するとき' do
      before do
        create(:admin_user, email: 'admin@example.com')
      end

      let(:admin_user) { build(:admin_user, email: 'admin@example.com') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(admin_user.errors.messages[:email]).to include 'はすでに存在します'
      end
    end

    context 'email がアルファベット・英数字のみのとき' do
      let(:admin_user) { build(:admin_user, email: Faker::Lorem.characters(number: 16)) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(admin_user.errors.messages[:email]).to include 'は不正な値です'
      end
    end

    context 'password が空のとき' do
      let(:admin_user) { build(:admin_user, password: '') }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(admin_user.errors.messages[:password]).to include 'を入力してください'
      end
    end

    context 'password が5文字以下のとき' do
      let(:admin_user) { build(:admin_user, password: 'a' * 5) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(admin_user.errors.messages[:password]).to include 'は6文字以上で入力してください'
      end
    end

    context 'password が129文字以上のとき' do
      let(:admin_user) { build(:admin_user, password: 'a' * 129) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(admin_user.errors.messages[:password]).to include 'は128文字以内で入力してください'
      end
    end
  end
end
