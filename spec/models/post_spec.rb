require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーション' do
    subject { post.valid? }

    context 'データが条件を満たすとき' do
      let(:post) { build(:post) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    # content のバリデーションテスト
    context 'content が空のとき' do
      let(:post) { build(:post, content: '') }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post.errors.messages[:content]).to include 'を入力してください'
        # expect { subject }.to raise_error 'バリデーションに失敗しました: 投稿内容を入力してください'
      end
    end

    context 'content が 2001 文字以上のとき' do
      let(:post) { build(:post, content: 'a' * 2001) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post.errors.messages[:content]).to include 'は2000文字以内で入力してください'
        # expect { subject }.to raise_error 'バリデーションに失敗しました: 投稿内容は2000文字以内で入力してください'
      end
    end
  end
end
