require 'rails_helper'

RSpec.describe KnowHow, type: :model do
  describe 'バリデーション' do
    subject { know_how.valid? }

    context 'データが条件を満たすとき' do
      let(:know_how) { build(:know_how) }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    context 'genre が空のとき' do
      let(:know_how) { build(:know_how, genre: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(know_how.errors.messages[:genre]).to include 'を入力してください'
      end
    end

    context 'title が空のとき' do
      let(:know_how) { build(:know_how, title: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(know_how.errors.messages[:title]).to include 'を入力してください'
      end
    end

    context 'content が空のとき' do
      let(:know_how) { build(:know_how, content: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(know_how.errors.messages[:content]).to include 'を入力してください'
      end
    end
  end

  context 'ノウハウを削除したとき' do
    subject { know_how.destroy }

    let(:know_how) { create(:know_how) }
    before do
      create(:progress)
      create_list(:progress, 2, know_how: know_how)
    end

    it 'そのノウハウの進捗状況も削除される' do
      expect { subject }.to change { know_how.progresses.count }.by(-2)
    end
  end
end
