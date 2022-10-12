require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'バリデーション' do
    subject { category.valid? }

    context 'データが条件を満たすとき' do
      let(:category) { build(:category) }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    context 'name が空のとき' do
      let(:category) { build(:category, name: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(category.errors.messages[:name]).to include 'を入力してください'
      end
    end
  end
end
