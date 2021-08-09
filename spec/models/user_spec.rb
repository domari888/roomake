require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    subject { user.valid? }

    context 'データが条件を満たすとき' do
      let(:user) { build(:user) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    # name のバリデーションテスト
    context 'name が空のとき' do
      let(:user) { build(:user, name: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:name]).to include 'を入力してください'
      end
    end

    context 'name が 31文字以上のとき' do
      let(:user) { build(:user, name: 'a' * 31) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:name]).to include 'は30文字以内で入力してください'
      end
    end

    # email のバリデーションテスト
    context 'email が空のとき' do
      let(:user) { build(:user, email: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include 'を入力してください'
      end
    end

    context 'email がすでに存在するとき' do
      before { create(:user, email: 'test@example.com') }

      let(:user) { build(:user, email: 'test@example.com') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include 'はすでに存在します'
      end
    end

    context 'email がアルファベット･英数字 のみのとき' do
      let(:user) { build(:user, email: Faker::Lorem.characters(number: 16)) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include 'は不正な値です'
      end
    end

    # password のバリデーションテスト
    context 'password が空のとき' do
      let(:user) { build(:user, password: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:password]).to include 'を入力してください'
      end
    end

    context 'password が 5 文字以下のとき' do
      let(:user) { build(:user, password: 'a' * 5) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:password]).to include 'は6文字以上で入力してください'
      end
    end

    context 'password が 129 文字以上のとき' do
      let(:user) { build(:user, password: 'a' * 129) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:password]).to include 'は128文字以内で入力してください'
      end
    end

    # age のバリデーションテスト
    context 'age が空のとき' do
      let(:user) { build(:user, age: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:age]).to include 'を入力してください'
      end
    end

    context 'age が文字列のとき' do
      let(:user) { build(:user, age: 'teens') }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    # address のバリデーションテスト
    context 'address が空のとき' do
      let(:user) { build(:user, address: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:address]).to include 'を入力してください'
      end
    end

    context 'address が文字列のとき' do
      let(:user) { build(:user, address: 'hokkaido') }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    # household のバリデーションテスト
    context 'household が空のとき' do
      let(:user) { build(:user, household: '') }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:household]).to include 'を入力してください'
      end
    end

    context 'household が文字列のとき' do
      let(:user) { build(:user, household: 'single_household') }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    # profile のバリデーションテスト
    context 'profile が 2001 文字以上のとき' do
      let(:user) { build(:user, profile: 'a' * 2001) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:profile]).to include 'は2000文字以内で入力してください'
      end
    end

    # avater のバリデーションテスト
    context 'avater の画像サイズが 5MB 以上のとき' do
      let(:user) { build(:user, avater: Rack::Test::UploadedFile.new(Rails.root.join('images/fallback/rspec_size_test.jpg'))) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:avater]).to include 'ファイルを5MBバイト以下のサイズにしてください'
      end
    end

    context 'avater の拡張子が .jpeg .jpg .png 以外のとき' do
      let(:user) { build(:user, avater: Rack::Test::UploadedFile.new(Rails.root.join('images/fallback/rspec_extension_test.tiff'))) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(user.errors.messages[:avater]).to include '"tiff"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpg, jpeg, png'
      end
    end
  end
end
