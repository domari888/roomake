require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe 'コメント追加' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    context '投稿にコメントした場合' do
      let(:comment) { build(:comment, user: user) }
      it 'その投稿のコメント数が1つ増えること', js: true do
        visit post_path(post)
        expect do
          within '.comment-container' do
            expect(page).not_to have_content comment.content
          end
          within '.comment-group' do
            find('#comment_content').set(comment.content)
            click_on '送信する'
          end
          within '.comment-container' do
            expect(page).to have_content comment.content
          end
          expect(page).to have_selector '#flash-messages', text: 'コメントを投稿しました'
        end.to change { post.comments.count }.by(1)
      end
    end

    context '投稿のコメントを削除した場合' do
      before do
        @comment = create(:comment, post: post, user: user)
        create(:comment, post: post)
      end

      it 'その投稿のコメント数が1つ減ること', js: true do
        visit post_path(post)
        expect do
          within '.comment-container' do
            expect(page).to have_content @comment.content
            find("a[href='#{post_comment_path(post, @comment)}']").click
            page.accept_confirm
            expect(page).not_to have_content @comment.content
          end
          expect(page).to have_selector '#flash-messages', text: 'コメントを削除しました'
        end.to change { post.comments.count }.by(-1)
      end
    end

    context 'コメントが条件を満たさない場合' do
      it 'エラーメッセージが表示され、コメントが作成されないこと', js: true do
        visit post_path(post)
        expect do
          within '.comment-group' do
            find('#comment_content').set('')
            click_on '送信する'
          end
          expect(page).to have_selector '#comment-error-messages', text: 'コメント内容を入力してください'
        end.to change { post.comments.count }.by(0)
      end
    end
  end
end
