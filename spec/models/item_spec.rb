require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'バリデーション' do
    subject { item.valid? }

    context 'データが条件を満たすとき' do
      let(:item) { build(:item) }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    context 'name が空のとき' do
      let(:item) { build(:item, name: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(item.errors.messages[:name]).to include 'を入力してください'
      end
    end

    context '同じアイテムを追加したとき' do
      let(:user) { build(:user) }
      let(:item) { build(:item, name: 'テストアイテム', user: user) }
      before do
        create(:item, name: 'テストアイテム', user: user)
      end

      it 'エラーが発生する' do
        expect(subject).to be false
        expect(item.errors.messages[:name]).to include 'は既に登録されています'
      end
    end

    context 'user_id が空のとき' do
      let(:item) { build(:item, user_id: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(item.errors.messages[:user]).to include 'を入力してください'
      end
    end
  end
end
