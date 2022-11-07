require 'rails_helper'

RSpec.describe Home, type: :model do
  describe 'バリデーション' do
    subject { home.valid? }

    context 'データが条件を満たすとき' do
      let(:home) { build(:home) }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    context 'title が空のとき' do
      let(:home) { build(:home, title: '') }
      it 'エラーが発生すること' do
        expect(subject).to be false
        expect(home.errors.messages[:title]).to include 'を入力してください'
      end
    end

    context 'subtitle が空のとき' do
      let(:home) { build(:home, subtitle: '') }
      it 'エラーが発生すること' do
        expect(subject).to be false
        expect(home.errors.messages[:subtitle]).to include 'を入力してください'
      end
    end

    context 'image が空のとき' do
      let(:home) { build(:home, image: '') }
      it 'エラーが発生すること' do
        expect(subject).to be false
        expect(home.errors.messages[:image]).to include 'を入力してください'
      end
    end

    context 'content が空のとき' do
      let(:home) { build(:home, content: '') }
      it 'エラーが発生すること' do
        expect(subject).to be false
        expect(home.errors.messages[:content]).to include 'を入力してください'
      end
    end
  end
end
