require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー詳細ページ' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    context 'マイページへ遷移したとき' do
      before do
        create(:post, user: user)
        create(:like, user: user)
        create(:mark, user: user)
        create(:item, user: user)
      end

      it 'ログインユーザーの情報が表示されていること' do
        visit user_path(user)
        expect(page).to have_selector "img[src='#{user.avatar.url}']"
        expect(page).to have_content user.name
        expect(page).to have_content user.address_i18n
        expect(page).to have_content user.favorite_items
        expect(page).to have_content user.profile
        expect(page).to have_css '#user-menu-list'
        user.post_with_photos.each do |post|
          expect(page).to have_selector "img[src='#{post.photos.first.image.url}']"
        end
        user.like_with_photos.each do |post|
          expect(page).to have_selector "img[src='#{post.photos.first.image.url}']"
        end
        user.mark_with_photos.each do |post|
          expect(page).to have_selector "img[src='#{post.photos.first.image.url}']"
        end
        user.items.each do |item|
          expect(page).not_to have_content item.name
        end
      end
    end

    context '他ユーザー詳細ページへ遷移したとき' do
      let(:other_user) { create(:user) }
      before do
        create(:post, user: other_user)
        create(:like, user: other_user)
        create(:mark, user: other_user)
        create(:item, user: other_user)
      end

      it 'そのユーザーの情報が表示されていること' do
        visit user_path(other_user)
        expect(page).to have_content other_user.name
        expect(page).to have_content other_user.address_i18n
        expect(page).to have_content other_user.favorite_items
        expect(page).to have_content other_user.profile
        expect(page).not_to have_css '#user-menu-list'
        other_user.post_with_photos.each do |post|
          expect(page).to have_selector "img[src='#{post.photos.first.image.url}']"
        end
        other_user.like_with_photos.each do |post|
          expect(page).to have_selector "img[src='#{post.photos.first.image.url}']"
        end
        other_user.items.each do |item|
          expect(page).to have_content item.name
        end
        other_user.mark_with_photos.each do |post|
          expect(page).not_to have_selector "img[src='#{post.photos.first.image.url}']"
        end
      end
    end
  end

  describe 'アカウント登録' do
    before do
      visit new_user_registration_path
      fill_in 'ユーザーネーム', with: user.name
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      fill_in 'パスワード（確認用）', with: user.password
      select user.age_i18n, from: '年代'
      select user.address_i18n, from: 'お住まい'
      select user.household_i18n, from: '家族構成'
      check '利用規約について同意する'
    end

    context '入力情報が条件を満たすとき' do
      let(:user) { build(:user) }
      it '新規登録ができること' do
        click_button '会員登録'
        expect(page).to have_current_path posts_path
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end

    context 'パスワードとパスワード(確認用)が一致しないとき' do
      let(:user) { build(:user, password: 'password') }
      it 'エラーが発生すること' do
        fill_in 'パスワード（確認用）', with: 'confirm_password'
        click_button '会員登録'
        expect(page).to have_current_path '/users'
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
      end
    end

    context 'メールアドレスがすでに登録済みの場合' do
      before { create(:user, email: 'test@example.com') }

      let(:user) { build(:user, email: 'test@example.com') }
      it 'エラーが発生すること' do
        click_button '会員登録'
        expect(page).to have_current_path '/users'
        expect(page).to have_content 'メールアドレスはすでに存在します'
      end
    end

    context '画像ファイルが条件を満たさないとき' do
      let(:user) { build(:user) }
      it 'エラーが発生すること' do
        attach_file('user[avatar]', Rails.root.join('spec/fixtures/rspec_size_test.jpg'))
        click_button '会員登録'
        expect(page).to have_current_path '/users'
        expect(page).to have_content 'プロフィール画像ファイルを5MBバイト以下のサイズにしてください'
      end
    end
  end

  describe 'アカウント編集・削除' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    context 'アカウント編集ページに遷移したとき' do
      let(:user) { create(:user) }
      it '現在のユーザー情報が入力されていること' do
        visit edit_user_registration_path
        expect(page).to have_selector "img[src$='#{user.avatar.filename}']"
        expect(page).to have_field 'ユーザーネーム', with: user.name
        expect(page).to have_field 'メールアドレス', with: user.email
        expect(page).to have_select('年代', selected: user.age_i18n)
        expect(page).to have_select('お住まい', selected: user.address_i18n)
        expect(page).to have_select('家族構成', selected: user.household_i18n)
        expect(page).to have_field 'お気に入りの家具・家電', with: user.favorite_items if user.favorite_items.present?
        expect(page).to have_field 'プロフィール', with: user.profile if user.profile.present?
      end
    end

    context 'アカウント情報を更新したとき' do
      let(:user) { create(:user) }
      let(:updated_user) { build(:user) }
      before do
        visit edit_user_registration_path
        attach_file('user[avatar]', Rails.root.join('spec/fixtures/test.jpg'))
        fill_in 'ユーザーネーム', with: updated_user.name
        fill_in '現在のパスワード', with: user.password
        select updated_user.address_i18n, from: 'お住まい'
        fill_in 'お気に入りの家具・家電', with: updated_user.favorite_items
        fill_in 'プロフィール', with: updated_user.profile
        click_on '変更する'
      end

      it 'マイページの内容が更新されること' do
        visit user_path(user)
        expect(page).to have_current_path user_path(user)
        expect(page).to have_selector "img[src$='test.jpg']"
        expect(page).to have_content updated_user.name
        expect(page).to have_content updated_user.address_i18n
        expect(page).to have_content updated_user.favorite_items
        expect(page).to have_content updated_user.profile
      end
    end

    context 'アカウント削除ボタンを押下したとき' do
      let(:user) { create(:user) }
      it '削除されること' do
        visit edit_user_registration_path
        click_on 'アカウント削除'
        expect(page).to have_current_path root_path
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end
    end
  end

  context 'ゲストユーザーの削除・更新をしようとした場合' do
    before do
      visit root_path
      first('.guest-login').click
    end

    it 'エラーが発生すること' do
      visit edit_user_registration_path
      click_on 'アカウント削除'
      expect(page).to have_content 'ゲストユーザーの削除・更新はできません'
    end
  end
end
