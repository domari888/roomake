require 'rails_helper'

RSpec.describe PostForm, type: :model do
  describe 'バリデーション' do
    subject { post_form.valid? }

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
        expect(post_form.errors.messages[:tag_ids]).to include 'は2文字以内で入力してください'
      end
    end

    context 'tag_ids の値が18以上のとき' do
      let(:post_form) { build(:post_form, tag_ids: [19]) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:tag_ids]).to include '入力された値は存在しません'
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
        expect(post_form.errors.messages[:category_ids]).to include 'は2文字以内で入力してください'
      end
    end

    context 'categoryr_ids の値が18以上のとき' do
      let(:post_form) { build(:post_form, category_ids: [19]) }
      it 'エラーが発生すること' do
        expect(subject).to eq false
        expect(post_form.errors.messages[:category_ids]).to include '入力された値は存在しません'
      end
    end

    context 'image が空のとき' do
      let(:post_form) { build(:post_form, image: '') }
      it 'エラーが発生する' do
        expect(post_form.valid?(:create)).to eq false
        expect(post_form.errors.messages[:image]).to include 'を入力してください'
      end
    end

    context 'image が6枚以上のとき' do
      before do
        @images = []
        7.times { @images << Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
      end

      let(:post_form) { build(:post_form, image: @images) }
      it 'エラーが発生する' do
        expect(post_form.valid?(:create)).to eq false
        expect(post_form.errors.messages[:image]).to include 'は最大6枚まで選択できます'
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

      context '画像が1つも選択されていない場合' do
        let(:post_form) { build(:post_form, post: post, delete_ids: [2], image: '') }
        it '更新されないこと' do
          expect { subject }.to change { post.photos.count }.by(0)
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

      context '画像が選択されていない場合' do
        let(:post_form) { build(:post_form, user_id: user.id, image: '') }
        it 'エラーが発生すること' do
          expect(subject).to eq false
        end
      end
    end
  end
end
