require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    subject { user.valid? }

    context 'データが条件を満たすとき' do
      let(:user) { build(:user) }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    # name のバリデーションテスト
    context 'name が空のとき' do
      let(:user) { build(:user, name: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:name]).to include 'を入力してください'
      end
    end

    context 'name が 31文字以上のとき' do
      let(:user) { build(:user, name: 'a' * 31) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:name]).to include 'は30文字以内で入力してください'
      end
    end

    # email のバリデーションテスト
    context 'email が空のとき' do
      let(:user) { build(:user, email: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:email]).to include 'を入力してください'
      end
    end

    context 'email がすでに存在するとき' do
      before { create(:user, email: 'test@example.com') }

      let(:user) { build(:user, email: 'test@example.com') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:email]).to include 'はすでに存在します'
      end
    end

    context 'email がアルファベット･英数字 のみのとき' do
      let(:user) { build(:user, email: Faker::Lorem.characters(number: 16)) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:email]).to include 'は不正な値です'
      end
    end

    # password のバリデーションテスト
    context 'password が空のとき' do
      let(:user) { build(:user, password: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:password]).to include 'を入力してください'
      end
    end

    context 'password が 5 文字以下のとき' do
      let(:user) { build(:user, password: 'a' * 5) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:password]).to include 'は6文字以上で入力してください'
      end
    end

    context 'password が 129 文字以上のとき' do
      let(:user) { build(:user, password: 'a' * 129) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:password]).to include 'は128文字以内で入力してください'
      end
    end

    # age のバリデーションテスト
    context 'age が空のとき' do
      let(:user) { build(:user, age: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:age]).to include 'を入力してください'
      end
    end

    context 'age が文字列のとき' do
      let(:user) { build(:user, age: 'teens') }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    # address のバリデーションテスト
    context 'address が空のとき' do
      let(:user) { build(:user, address: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:address]).to include 'を入力してください'
      end
    end

    context 'address が文字列のとき' do
      let(:user) { build(:user, address: 'hokkaido') }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    # household のバリデーションテスト
    context 'household が空のとき' do
      let(:user) { build(:user, household: '') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:household]).to include 'を入力してください'
      end
    end

    context 'household が文字列のとき' do
      let(:user) { build(:user, household: 'single_household') }
      it '保存できること' do
        expect(subject).to be true
      end
    end

    # profile のバリデーションテスト
    context 'profile が 2001 文字以上のとき' do
      let(:user) { build(:user, profile: 'a' * 2001) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:profile]).to include 'は2000文字以内で入力してください'
      end
    end

    # avatar のバリデーションテスト
    context 'avatar の画像サイズが 5MB 以上のとき' do
      let(:user) { build(:user, avatar: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/rspec_size_test.jpg'))) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:avatar]).to include 'ファイルを5MBバイト以下のサイズにしてください'
      end
    end

    context 'avatar の拡張子が .jpeg .jpg .png 以外のとき' do
      let(:user) { build(:user, avatar: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/rspec_extension_test.tiff'))) }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:avatar]).to include '"tiff"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpg, jpeg, png'
      end
    end

    context '利用規約とプライバシーポリシーに同意していないとき' do
      let(:user) { build(:user, agreement: '0') }
      it 'エラーが発生する' do
        expect(subject).to be false
        expect(user.errors.messages[:agreement]).to include 'について同意してください'
      end
    end
  end

  context 'ユーザーが削除されたとき' do
    subject { user.destroy }

    let(:user) { create(:user) }
    before do
      FactoryBot.rewind_sequences
      create(:like)
      create(:mark)
      create(:comment)
      create(:progress)
      create_list(:post, 2, user: user)
      create_list(:like, 2, user: user)
      create_list(:mark, 2, user: user)
      create_list(:comment, 2, user: user)
      create_list(:progress, 2, user: user)
    end

    it 'そのユーザーの投稿も削除される' do
      expect { subject }.to change { user.posts.count }.by(-2)
    end

    it 'そのユーザーのいいねも削除される' do
      expect { subject }.to change { user.likes.count }.by(-2)
    end

    it 'そのユーザーのマークも削除される' do
      expect { subject }.to change { user.marks.count }.by(-2)
    end

    it 'そのユーザーのコメントも削除される' do
      expect { subject }.to change { user.comments.count }.by(-2)
    end

    it 'そのユーザーの進捗状況も削除される' do
      expect { subject }.to change { user.progresses.count }.by(-2)
    end
  end

  describe 'メソッド' do
    let(:user) { create(:user) }
    let(:post1) { create(:post, id: 1, user: user) }
    let(:post2) { create(:post, id: 2, user: user) }
    let(:post3) { create(:post, id: 3, user: user) }

    describe '#post_with_photos' do
      context '投稿が存在する場合' do
        before do
          post1
          post2
          post3
        end

        it '投稿一覧を降順で取得できること' do
          expect(user.post_with_photos.map(&:id)).to eq [3, 2, 1]
        end
      end

      context '投稿が存在しない場合' do
        it '空の配列を返す' do
          expect(user.post_with_photos).to be_empty
        end
      end
    end

    describe '#like_with_photos' do
      context 'いいねした投稿が存在する場合' do
        before do
          create(:like, post: post1, user: user)
          create(:like, post: post2, user: user)
          create(:like, post: post3, user: user)
          create(:like)
        end

        it 'いいねした投稿を降順で取得できること' do
          expect(user.like_with_photos.map(&:id)).to eq [3, 2, 1]
        end
      end

      context 'いいねした投稿が存在しない場合' do
        it '空の配列を返す' do
          expect(user.like_with_photos).to be_empty
        end
      end
    end

    describe '#mark_with_photos' do
      context 'マークした投稿が存在する場合' do
        before do
          create(:mark, post: post1, user: user)
          create(:mark, post: post2, user: user)
          create(:mark, post: post3, user: user)
          create(:mark)
        end

        it 'マークした投稿を降順で取得できること' do
          expect(user.mark_with_photos.map(&:id)).to eq [3, 2, 1]
        end
      end

      context 'マークした投稿が存在しない場合' do
        it '空の配列を返す' do
          expect(user.mark_with_photos).to be_empty
        end
      end
    end

    describe '#self.guest' do
      context 'ゲストユーザーのデータがまだ存在しない場合' do
        let(:user) { build(:guest_user) }
        it '保存できること' do
          expect(user.valid?).to be true
        end
      end

      context 'ゲストユーザーの email がすでに存在するとき' do
        let(:user) { build(:guest_user, email: 'guest@example.com') }
        let(:guest) { User.find_by(email: 'guest@example.com') }
        it '既存のレコードを取得' do
          expect(User.guest).to eq guest
        end
      end
    end
  end
end
