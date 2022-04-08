require 'rails_helper'

RSpec.describe KnowHow, type: :model do
  describe 'バリデーション' do
    subject { know_how.valid? }

    context 'データが条件を満たすとき' do
      let(:know_how) { build(:know_how) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    context 'genre が空のとき' do
      let(:know_how) { build(:know_how, genre: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(know_how.errors.messages[:genre]).to include 'を入力してください'
      end
    end

    context 'title が空のとき' do
      let(:know_how) { build(:know_how, title: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(know_how.errors.messages[:title]).to include 'を入力してください'
      end
    end

    context 'content が空のとき' do
      let(:know_how) { build(:know_how, content: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(know_how.errors.messages[:content]).to include 'を入力してください'
      end
    end
  end
end
