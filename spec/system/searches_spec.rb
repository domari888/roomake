require 'rails_helper'

RSpec.describe '投稿検索機能', type: :system do
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '投稿検索モーダル' do
    let(:user) { create(:user) }
    before do
      FactoryBot.rewind_sequences
      create_list(:post, 2)
      visit current_path
    end

    context '検索条件を設定した場合' do
      let(:post) { Post.first }
      it 'その条件を含む投稿が表示されること', js: true do
        find('.navbar-toggler').click
        within '.navbar-collapse' do
          click_on '検索する'
        end
        within '.modal-content' do
          fill_in 'キーワード', with: post.content
          find('label', text: post.tags.first.name).click
          find('label', text: post.categories.first.name).click
          click_on '検索する'
        end
        within first('.card') do
          expect(page).to have_content post.content
          # expect(page).to have_content post.tags.first.name
          # expect(page).to have_content post.categories.first.name
        end
      end
    end

    context '条件を設定しない場合' do
      let(:post_last) { Post.last }
      it '投稿日時が降順で表示されること', js: true do
        find('.navbar-toggler').click
        within '.navbar-collapse' do
          click_on '検索する'
        end
        within '.modal-content' do
          click_on '検索する'
        end
        within first('.card') do
          expect(page).to have_content post_last.content
          # expect(page).to have_content post_last.tags.first.name
          # expect(page).to have_content post_last.categories.first.name
        end
      end
    end

    context '検索条件が一致する投稿がない場合' do
      it '投稿が表示されないこと', js: true do
        find('.navbar-toggler').click
        within '.navbar-collapse' do
          click_on '検索する'
        end
        within '.modal-content' do
          fill_in 'キーワード', with: 'テスト投稿'
          click_on '検索する'
        end
        expect(page).not_to have_selector '.card'
        expect(page).to have_content '検索結果が見つかりませんでした'
      end
    end

    context '検索モーダルでリセットボタンを押下したとき' do
      it '設定済みの検索条件が一括リセットされること', js: true do
        find('.navbar-toggler').click
        within '.navbar-collapse' do
          click_on '検索する'
        end
        within '.modal-content' do
          fill_in 'キーワード', with: 'テスト投稿'
          find('label', text: 'タグ1').click
          find('label', text: 'カテゴリ1').click
          click_on 'リセット'
          expect(page).not_to have_field 'キーワード', with: 'テスト投稿'
          expect(page).to have_unchecked_field('タグ1', visible: :hidden)
          expect(page).to have_unchecked_field('カテゴリ1', visible: :hidden)
        end
      end
    end
  end
end
