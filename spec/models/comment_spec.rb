require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーション' do
    subject { comment.valid? }

    context 'データが条件を満たすとき' do
      let(:comment) { build(:comment) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    context 'content が空のとき' do
      let(:comment) { build(:comment, content: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(comment.errors.messages[:content]).to include 'を入力してください'
      end
    end

    context 'content が141文字以上のとき' do
      let(:comment) { build(:comment, content: 'a' * 141) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(comment.errors.messages[:content]).to include 'は140文字以内で入力してください'
      end
    end

    context 'user_id が空のとき' do
      let(:comment) { build(:comment, user_id: nil) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(comment.errors.messages[:user]).to include 'を入力してください'
      end
    end

    context 'post_id が空のとき' do
      let(:comment) { build(:comment, post_id: nil) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(comment.errors.messages[:post]).to include 'を入力してください'
      end
    end
  end
end
