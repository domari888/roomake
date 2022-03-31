require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'バリデーション' do
    subject { tag.valid? }

    context 'データが条件を満たすとき' do
      let(:tag) { build(:tag) }
      it '保存されること' do
        expect(subject).to eq true
      end
    end

    context 'name が空のとき' do
      let(:tag) { build(:tag, name: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(tag.errors.messages[:name]).to include 'を入力してください'
      end
    end
  end
end
