require 'rails_helper'

RSpec.describe PostTag, type: :model do
  describe 'バリデーション' do
    subject { post_tag.valid? }

    context 'データが条件を満たすとき' do
      let(:post_tag) { build(:post_tag) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    context 'post_id が空のとき' do
      let(:post_tag) { build(:post_tag, post_id: nil) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(post_tag.errors.messages[:post]).to include 'を入力してください'
      end
    end

    context 'tag_id がからのとき' do
      let(:post_tag) { build(:post_tag, tag_id: nil) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(post_tag.errors.messages[:tag]).to include 'を入力してください'
      end
    end

    context '1つの投稿に同じタグを付けた場合' do
      let(:post) { build(:post) }
      let(:tag) { build(:tag) }
      let(:post_tag) { build(:post_tag, post: post, tag: tag) }
      before do
        create(:post_tag, post: post, tag: tag)
      end

      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(post_tag.errors.messages[:post_id]).to include 'ではすでにこのタグが選択されています'
      end
    end
  end
end
