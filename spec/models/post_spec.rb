require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'メソッド' do
    let(:user) { build(:user) }
    let(:post1) { build(:post) }
    let(:post2) { build(:post) }
    describe '#liked_by?' do
      before do
        create(:like, user: user, post: post1)
        create_list(:like, 2)
      end

      context 'いいねした投稿の場合' do
        it 'true となること' do
          expect(post1.liked_by?(user)).to eq true
        end
      end

      context 'いいねした投稿では無い場合' do
        it 'false となること' do
          expect(post2.liked_by?(user)).to eq false
        end
      end
    end

    describe '#marked_by?' do
      before do
        create(:mark, user: user, post: post1)
        create_list(:mark, 2)
      end

      context 'マークした投稿の場合' do
        it 'true となること' do
          expect(post1.marked_by?(user)).to eq true
        end
      end

      context 'マークした投稿では無い場合' do
        it 'false となること' do
          expect(post2.marked_by?(user)).to eq false
        end
      end
    end
  end

  context '投稿を削除したとき' do
    subject { post.destroy }

    let(:post) { create(:post) }
    before do
      create(:like)
      create(:mark)
      create_list(:like, 2, post: post)
      create_list(:mark, 2, post: post)
      create_list(:photo, 2, post: post)
      create(:post_tag, post: post)
      create(:post_category, post: post)
    end

    it 'その投稿のいいねも削除される' do
      expect { subject }.to change { post.likes.count }.by(-2)
    end

    it 'その投稿のマークも削除される' do
      expect { subject }.to change { post.marks.count }.by(-2)
    end

    it 'その投稿の画像も削除される' do
      expect { subject }.to change { post.photos.count }.by(-3)
    end

    it 'その投稿のタグも削除される' do
      expect { subject }.to change { post.post_tags.count }.by(-2)
    end

    it 'その投稿のカテゴリも削除される' do
      expect { subject }.to change { post.post_categories.count }.by(-2)
    end
  end
end
