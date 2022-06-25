require 'rails_helper'

RSpec.describe 'ノウハウ機能', type: :system do
  let(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe 'ノウハウ一覧ページの表示' do
    context 'ノウハウ一覧ページへ遷移したとき' do
      let(:know_hows_title) { KnowHow.pluck(:title) }
      before do
        FactoryBot.rewind_sequences
        create_list(:know_how, KnowHow.genres.count)
      end

      it 'ノウハウが全て表示されていること' do
        visit know_hows_path
        all('.list-group-item').each.with_index do |list, i|
          within list do
            expect(page).to have_content know_hows_title[i]
          end
        end
      end
    end
  end

  describe 'ノウハウ詳細ページの表示' do
    context 'ノウハウ詳細ページへ遷移したとき' do
      let(:know_how_first) { KnowHow.first }
      before do
        FactoryBot.rewind_sequences
        create_list(:know_how, KnowHow.genres.count)
      end

      it 'タイトル・内容が表示されていること', js: true do
        visit know_hows_path
        find("a[href='#{know_how_path(know_how_first)}']").click
        within '.modal-content' do
          expect(page).to have_content know_how_first.title
          expect(page).to have_content know_how_first.content
        end
      end
    end
  end
end
