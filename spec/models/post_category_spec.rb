require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  describe 'バリデーション' do
    subject { post_category.valid? }

    context 'データが条件を満たすとき' do
      let(:post_category) { build(:post_category) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    context 'post_id が空のとき' do
      let(:post_category) { build(:post_category, post_id: nil) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_category.errors.messages[:post]).to include 'を入力してください'
      end
    end

    context 'category_id が空のとき' do
      let(:post_category) { build(:post_category, category_id: nil) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(post_category.errors.messages[:category]).to include 'を入力してください'
      end
    end

    context '1つの投稿に同じカテゴリをつけた場合' do
      let(:post) { build(:post) }
      let(:category) { build(:category) }
      let(:post_category) { build(:post_category, post: post, category: category) }
      before do
        create(:post_category, post: post, category: category)
      end

      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(post_category.errors.messages[:post_id]).to include 'ではすでにこのカテゴリが選択されています'
      end
    end
  end
end
