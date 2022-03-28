require 'rails_helper'

RSpec.describe Mark, type: :model do
  describe 'バリデーション' do
    subject { mark.valid? }

    context 'データが条件を満たすとき' do
      let(:mark) { build(:mark) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    context 'user_id が空のとき' do
      let(:mark) { build(:mark, user_id: nil) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(mark.errors.messages[:user]).to include 'を入力してください'
      end
    end

    context 'post_id が空のとき' do
      let(:mark) { build(:mark, post_id: nil) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(mark.errors.messages[:post]).to include 'を入力してください'
      end
    end

    context '同じ投稿をマークした場合' do
      let(:user) { build(:user) }
      let(:post) { build(:post) }
      let(:mark) { build(:mark, user: user, post: post) }
      before do
        create(:mark, user: user, post: post)
      end

      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(mark.errors.messages[:user_id]).to include 'は同じ投稿に2回以上マークはできません'
      end
    end
  end
end
