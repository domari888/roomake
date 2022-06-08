require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do
  let(:user) { create(:user) }
  before do
    post
    create_list(:post, 2)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '未いいねの投稿の場合' do
    let(:post) { create(:post) }
    context 'タイムラインページでいいねボタンを押下したとき' do
      it 'その投稿のいいね数が1つ増えること', js: true do
        expect do
          within "#post-#{post.id}-like" do
            expect(page).not_to have_css '.like-color'
            find("a[href='#{post_likes_path(post)}']").click
            expect(page).to have_css '.like-color'
          end
        end.to change { post.likes.count }.by(1)
      end
    end

    context '投稿詳細ページでいいねボタンを押下したとき' do
      it 'その投稿のいいね数が1つ増えること', js: true do
        visit post_path(post)
        expect do
          expect(page).not_to have_css '.like-color'
          find("a[href='#{post_likes_path(post)}']").click
          expect(page).to have_css '.like-color'
        end.to change { post.likes.count }.by(1)
      end
    end
  end

  describe 'いいね済みの投稿の場合' do
    let(:post) { create(:post) }
    before do
      create(:like, user: user, post: post)
    end

    context 'タイムラインページでいいねボタンを押下したとき' do
      it 'その投稿のいいね数が1つ減ること', js: true do
        visit current_path
        expect do
          within "#post-#{post.id}-like" do
            expect(page).not_to have_css '.dislike-color'
            find("a[href='#{post_likes_path(post)}']").click
            expect(page).to have_css '.dislike-color'
          end
        end.to change { post.likes.count }.by(-1)
      end
    end

    context '投稿詳細ページでいいねボタンを押下したとき' do
      it 'その投稿のいいね数が1つ減ること', js: true do
        visit post_path(post)
        expect do
          expect(page).not_to have_css '.dislike-color'
          find("a[href='#{post_likes_path(post)}']").click
          expect(page).to have_css '.dislike-color'
        end.to change { post.likes.count }.by(-1)
      end
    end
  end
end
