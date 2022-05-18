require 'rails_helper'

RSpec.describe 'ログイン・ログアウト', type: :system do
  describe 'ログイン' do
    let(:user) { create(:user) }
    context '入力情報が正しいとき' do
      it 'ログインできること' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        expect(page).to have_current_path posts_path
        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'メールアドレスが間違っているとき' do
      it 'ログインページにリダイレクトすること' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'email@email'
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        expect(page).to have_current_path new_user_session_path
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end

    context 'パスワードが間違っているとき' do
      it 'ログインページにリダイレクトすること' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'pass'
        click_button 'ログイン'
        expect(page).to have_current_path new_user_session_path
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
  end

  describe 'ログアウト' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ログアウトできること' do
      click_on 'ログアウト'
      expect(page).to have_current_path root_path
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  describe 'ゲストユーザーログイン' do
    context 'ゲストログインボタンを押下したとき' do
      it 'ゲストユーザーとしてログインできること' do
        visit root_path
        first('.guest-login').click
        expect(page).to have_current_path root_path
        expect(page).to have_content 'ゲストユーザーでログインしました'
      end
    end
  end
end
