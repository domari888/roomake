require 'rails_helper'

RSpec.describe PostForm, type: :model do
  describe 'バリデーション' do
    subject { post_form.valid? }

    before do
      FactoryBot.rewind_sequences
      create_list(:tag, 3)
      create_list(:category, 3)
    end

    context 'データが条件を満たすとき' do
      let(:post_form) { build(:post_form) }
      it '保存できること' do
        expect(subject).to eq true
      end
    end

    context 'content が空のとき' do
      let(:post_form) { build(:post_form, content: '') }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:content]).to include 'を入力してください'
      end
    end

    context 'content が 2001 文字以上のとき' do
      let(:post_form) { build(:post_form, content: 'a' * 2001) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:content]).to include 'は2000文字以内で入力してください'
      end
    end

    context 'tag_ids が空のとき' do
      let(:post_form) { build(:post_form, tag_ids: '') }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:tag_ids]).to include 'を入力してください'
      end
    end

    context 'tag_ids が3つ以上のとき' do
      let(:post_form) { build(:post_form, tag_ids: [1, 2, 3]) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:tag_ids]).to include 'は最大2つまで選択できます'
      end
    end

    context 'tag_ids の値と同じ id のタグが存在しない場合' do
      let(:post_form) { build(:post_form, tag_ids: [4]) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:tag_ids]).to include 'は選択肢の中から選んで下さい'
      end
    end

    context 'categoryr_ids が空のとき' do
      let(:post_form) { build(:post_form, category_ids: '') }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:category_ids]).to include 'を入力してください'
      end
    end

    context 'categoryr_ids が3つ以上のとき' do
      let(:post_form) { build(:post_form, category_ids: [1, 2, 3]) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:category_ids]).to include 'は最大2つまで選択できます'
      end
    end

    context 'categoryr_ids の値と同じ id のカテゴリが存在しない場合' do
      let(:post_form) { build(:post_form, category_ids: [4]) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:category_ids]).to include 'は選択肢の中から選んで下さい'
      end
    end

    context 'images が空のとき' do
      let(:post_form) { build(:post_form, images: '') }
      it 'エラーが発生する' do
        expect(post_form.valid?(:create)).to eq false
        expect(post_form.errors.messages[:images]).to include 'を選択してください'
      end
    end

    context 'images が6枚以上のとき' do
      before do
        @images = []
        7.times { @images << Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
      end

      let(:post_form) { build(:post_form, images: @images) }
      it 'エラーが発生する' do
        expect(post_form.valid?(:create)).to eq false
        expect(post_form.errors.messages[:images]).to include 'は最大6枚まで選択できます'
      end
    end
  end

  describe '#save' do
    subject { post_form.save }

    let(:user) { create(:user) }
    before do
      FactoryBot.rewind_sequences
      create_list(:tag, 2)
      create_list(:category, 2)
    end

    describe '#post_update' do
      let(:post) { create(:post, user: user) }

      context 'データが条件を満たすとき' do
        let(:post_form) { build(:post_form, post: post) }
        it '更新できること' do
          expect(subject).to eq true
        end
      end
    end

    describe '#post_create' do
      context 'データが条件を満たすとき' do
        let(:post_form) { build(:post_form, user_id: user.id) }
        it '新規作成できること' do
          expect { subject }.to change { user.posts.count }.by(1)
        end
      end
    end

    context '画像ファイルサイズが 5MB より大きいのとき' do
      let(:post_form) { build(:post_form, images: [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/rspec_size_test.jpg'))]) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(post_form.errors.full_messages).to include 'Imageファイルを5MBバイト以下のサイズにしてください'
      end
    end

    context '画像ファイルタイプが jpg, jpeg, png 以外のとき' do
      let(:post_form) { build(:post_form, images: [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/rspec_extension_test.tiff'))]) }
      it 'エラーが発生する' do
        expect(subject).to eq false
        expect(post_form.errors.full_messages).to include 'Image"tiff"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpg, jpeg, png'
      end
    end
  end
end
