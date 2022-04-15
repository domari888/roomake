require 'rails_helper'

RSpec.describe Progress, type: :model do
  describe 'バリデーション' do
    subject { progress.valid? }

    context 'データが条件を満たすとき' do
      let(:progress) { build(:progress) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    context 'user_id が空のとき' do
      let(:progress) { build(:progress, user_id: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(progress.errors.messages[:user]).to include 'を入力してください'
      end
    end

    context 'know_how_id が空のとき' do
      let(:progress) { build(:progress, know_how_id: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(progress.errors.messages[:know_how]).to include 'を入力してください'
      end
    end

    context '同じノウハウをチェックしたとき' do
      let(:user) { build(:user) }
      let(:know_how) { build(:know_how) }
      let(:progress) { build(:progress, user: user, know_how: know_how) }
      before do
        create(:progress, user: user, know_how: know_how)
      end

      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(progress.errors.messages[:user_id]).to include 'は同じノウハウに2回以上チェックはできません'
      end
    end
  end
end
