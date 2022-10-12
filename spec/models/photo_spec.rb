require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'バリデーション' do
    subject { photo.valid? }

    context 'データが条件を満たすとき' do
      let(:photo) { build(:photo) }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    context 'image の画像サイズが 5MB 以上のとき' do
      let(:photo) { build(:photo, image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/rspec_size_test.jpg'))) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(photo.errors.messages[:image]).to include 'ファイルを5MBバイト以下のサイズにしてください'
      end
    end

    context 'image の拡張子が .jpeg .jpg .png 以外のとき' do
      let(:photo) { build(:photo, image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/rspec_extension_test.tiff'))) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(photo.errors.messages[:image]).to include '"tiff"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpg, jpeg, png'
      end
    end
  end
end
