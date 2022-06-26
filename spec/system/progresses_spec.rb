require 'rails_helper'

RSpec.describe 'ノウハウチェック機能', type: :system do
  let(:user) { create(:user) }
  let(:know_how_first) { KnowHow.first }
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '未チェックのノウハウの場合' do
    before do
      FactoryBot.rewind_sequences
      create_list(:know_how, KnowHow.genres.count)
    end

    context 'チェックボタンを押下したとき' do
      it 'そのノウハウの進捗状況が実行済みとなること', js: true do
        visit know_hows_path
        expect do
          within "#know-how-#{know_how_first.id}" do
            expect(page).not_to have_css '.text-success'
            find("a[href='#{know_how_progresses_path(know_how_first)}']").click
            expect(page).to have_css '.text-success'
          end
        end.to change { user.progresses.count }.by(1)
      end
    end
  end

  describe 'チェック済みのノウハウの場合' do
    before do
      FactoryBot.rewind_sequences
      create_list(:know_how, KnowHow.genres.count)
      create(:progress, user: user, know_how: know_how_first)
    end

    context 'チェックボタンを押下したとき' do
      it 'そのノウハウの進捗状況が未実行となること', js: true do
        visit know_hows_path
        expect do
          within "#know-how-#{know_how_first.id}" do
            expect(page).not_to have_css '.text-muted'
            find("a[href='#{know_how_progresses_path(know_how_first)}']").click
            expect(page).to have_css '.text-muted'
          end
        end.to change { user.progresses.count }.by(-1)
      end
    end
  end
end
