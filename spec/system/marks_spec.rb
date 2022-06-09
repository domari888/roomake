require 'rails_helper'

RSpec.describe 'マーク機能', type: :system do
  let(:user) { create(:user) }
  before do
    post
    create_list(:post, 2)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '未マークの投稿の場合' do
    let(:post) { create(:post) }
    context 'タイムラインページでマークボタンを押下したとき' do
      it 'その投稿のマーク数が1つ増えること', js: true do
        expect do
          within "#post-#{post.id}-mark" do
            expect(page).not_to have_css '.mark-color'
            find("a[href='#{post_marks_path(post)}']").click
            expect(page).to have_css '.mark-color'
          end
        end.to change { post.marks.count }.by(1)
      end
    end

    context '投稿詳細ページでマークボタンを押下したとき' do
      it 'その投稿のマーク数が1つ増えること', js: true do
        visit post_path(post)
        expect do
          expect(page).not_to have_css '.mark-color'
          find("a[href='#{post_marks_path(post)}']").click
          expect(page).to have_css '.mark-color'
        end.to change { post.marks.count }.by(1)
      end
    end
  end

  describe 'マーク済みの投稿の場合' do
    let(:post) { create(:post) }
    before do
      create(:mark, user: user, post: post)
    end

    context 'タイムラインページでマークボタンを押下したとき' do
      it 'その投稿のマーク数が1つ減ること', js: true do
        visit current_path
        expect do
          within "#post-#{post.id}-mark" do
            expect(page).not_to have_css '.unmark-color'
            find("a[href='#{post_marks_path(post)}']").click
            expect(page).to have_css '.unmark-color'
          end
        end.to change { post.marks.count }.by(-1)
      end
    end

    context '投稿詳細ページでマークボタンを押下したとき' do
      it 'その投稿のマーク数が1つ減ること', js: true do
        visit post_path(post)
        expect do
          expect(page).not_to have_css '.unmark-color'
          find("a[href='#{post_marks_path(post)}']").click
          expect(page).to have_css '.unmark-color'
        end.to change { post.marks.count }.by(-1)
      end
    end
  end
end
