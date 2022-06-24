require 'rails_helper'

RSpec.describe 'アイテム機能', type: :system do
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    visit user_items_path(user)
  end

  describe 'アイテム追加機能' do
    context '検索したアイテムの追加ボタンを押下したとき' do
      let(:user) { create(:user) }
      let(:item) { build(:item, user: user) }
      it 'そのアイテムがマイアイテムに追加されること' do
        visit user_items_path(user)
        product = [{ 'affiliateUrl' => Faker::Internet.url, 'mediumImageUrl' => item.remote_image_url, 'productName' => item.name, 'genreName' => item.genre }]
        search_items_mock = class_double(RakutenWebService::Ichiba::Product)
        allow(search_items_mock).to receive(:search)
        allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
        expect { search_items_mock.search }.not_to raise_error
        expect do
          within '.search-item-group' do
            click_on 'アイテムを追加する'
            fill_in 'keyword', with: 'テストアイテム'
            find('.input-group-append button').click
          end
          within '#search-item-list' do
            all('li')[0].click_on '追加'
          end
          expect(page).to have_content "#{user.items.first.name} をマイアイテムに追加しました"
          expect(page).to have_selector "img[src='#{user.items.first.image.url}']"
          expect(page).to have_content user.items.first.name
          expect(page).to have_content user.items.first.genre
        end.to change { user.items.count }.by(1)
      end
    end

    context '追加ボタンを押下したアイテムが既に登録済みのとき' do
      let(:user) { create(:user) }
      let(:item) { create(:item, image: nil, user: user) }
      it 'エラーが発生すること' do
        visit user_items_path(user)
        product = [{ 'affiliateUrl' => Faker::Internet.url, 'mediumImageUrl' => item.remote_image_url, 'productName' => item.name, 'genreName' => item.genre }]
        search_items_mock = class_double(RakutenWebService::Ichiba::Product)
        allow(search_items_mock).to receive(:search)
        allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
        expect { search_items_mock.search }.not_to raise_error
        expect do
          within '.search-item-group' do
            click_on 'アイテムを追加する'
            fill_in 'keyword', with: 'テストアイテム'
            find('.input-group-append button').click
          end
          within '#search-item-list' do
            all('li')[0].click_on '追加'
          end
          expect(page).to have_content "#{user.items.first.name} は既に登録されています"
          expect(page).to have_selector "img[src='#{user.items.first.image.url}']"
          expect(page).to have_content user.items.first.name
          expect(page).to have_content user.items.first.genre
        end.to change { user.items.count }.by(0)
      end
    end

    context 'アイテム追加の条件を満たさないとき' do
      let(:user) { create(:user) }
      let(:item) { build(:item, name: nil, user: user) }
      it 'エラーが発生すること' do
        visit user_items_path(user)
        product = [{ 'affiliateUrl' => Faker::Internet.url, 'mediumImageUrl' => item.remote_image_url, 'productName' => '', 'genreName' => item.genre }]
        search_items_mock = class_double(RakutenWebService::Ichiba::Product)
        allow(search_items_mock).to receive(:search)
        allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
        expect { search_items_mock.search }.not_to raise_error
        expect do
          within '.search-item-group' do
            click_on 'アイテムを追加する'
            fill_in 'keyword', with: 'テストアイテム'
            find('.input-group-append button').click
          end
          within '#search-item-list' do
            all('li')[0].click_on '追加'
          end
          expect(page).to have_content 'アイテムを追加することができませんでした'
        end.to change { user.items.count }.by(0)
      end
    end
  end

  describe 'アイテム削除機能' do
    context 'アイテム削除ボタンを押下したとき' do
      let(:user) { create(:user) }
      before do
        @item = create(:item, user: user)
      end

      it 'そのアイテムがマイアイテムから削除されること', js: true do
        visit user_items_path(user)
        expect do
          click_on "my-item-menu-#{@item.id}"
          click_on '削除'
          page.accept_confirm
          expect(page).to have_content "#{@item.name} を削除しました"
        end.to change { user.items.count }.by(-1)
      end
    end
  end
end
