require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'バリデーション' do
    subject { like.valid? }

    context 'データが条件を満たすとき' do
      let(:like) { build(:like) }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    context 'user_id が空のとき' do
      let(:like) { build(:like, user_id: nil) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(like.errors.messages[:user]).to include 'を入力してください'
      end
    end

    context 'post_id が空のとき' do
      let(:like) { build(:like, post_id: nil) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(like.errors.messages[:post]).to include 'を入力してください'
      end
    end

    context '同じ投稿をいいねした場合' do
      let(:user) { build(:user) }
      let(:post) { build(:post) }
      let(:like) { build(:like, user: user, post: post) }
      before do
        create(:like, user: user, post: post)
      end

      it 'エラーが発生する' do
        expect(subject).to be false
        expect(like.errors.messages[:user_id]).to include 'は同じ投稿に2回以上いいねはできません'
      end
    end
  end

  describe 'counter_cache' do
    let(:post) { create(:post) }
    let(:like) { create(:like, post: post) }
    context 'いいねが作成されたとき' do
      it 'その投稿の likes_count が増加すること' do
        expect { like }.to change(post, :likes_count).by(1)
      end
    end

    context 'いいねが削除されたとき' do
      before do
        like
      end

      it 'その投稿の likes_count が減少すること' do
        expect { like.destroy }.to change(post, :likes_count).by(-1)
      end
    end
  end
end
