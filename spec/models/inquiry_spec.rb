require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe 'バリデーション' do
    subject { inquiry.valid? }

    context 'データが条件を満たすとき' do
      let(:inquiry) { build(:inquiry) }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    context 'name が空の時' do
      let(:inquiry) { build(:inquiry, name: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:name]).to include 'を入力してください'
      end
    end

    context 'name が49文字以上のとき' do
      let(:inquiry) { build(:inquiry, name: 'a' * 49) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:name]).to include 'は48文字以内で入力してください'
      end
    end

    context 'name_kana が空のとき' do
      let(:inquiry) { build(:inquiry, name_kana: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:name_kana]).to include 'を入力してください'
      end
    end

    context 'name_kana が全角カタカナ以外のとき' do
      let(:inquiry) { build(:inquiry, name_kana: 'ﾌﾘｶﾞﾅ') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:name_kana]).to include 'は全角カタカナで入力してください'
      end
    end

    context 'name_kana が49文字以上のとき' do
      let(:inquiry) { build(:inquiry, name_kana: 'a' * 49) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:name_kana]).to include 'は48文字以内で入力してください'
      end
    end

    context 'email が空のとき' do
      let(:inquiry) { build(:inquiry, email: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:email]).to include 'を入力してください'
      end
    end

    context 'email がアルファベット・英数字のみのとき' do
      let(:inquiry) { build(:inquiry, email: Faker::Lorem.characters(number: 16)) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:email]).to include 'は不正な値です'
      end
    end

    context 'email が257文字以上のとき' do
      let(:inquiry) { build(:inquiry, email: Faker::Lorem.characters(number: 257)) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:email]).to include 'は256文字以内で入力してください'
      end
    end

    context 'content が空のとき' do
      let(:inquiry) { build(:inquiry, content: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:content]).to include 'を入力してください'
      end
    end

    context 'content が2001文字以上のとき' do
      let(:inquiry) { build(:inquiry, content: 'a' * 2001) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:content]).to include 'は2000文字以内で入力してください'
      end
    end

    context 'remote_ip が空のとき' do
      let(:inquiry) { build(:inquiry, remote_ip: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(inquiry.errors.messages[:remote_ip]).to include 'を入力してください'
      end
    end
  end
end
