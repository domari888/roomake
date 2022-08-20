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
    let(:user) { create(:user) }
    context '検索したアイテムの追加ボタンを押下したとき' do
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
            fill_in 'keyword', with: item.name
            find('.input-group-append button').click
          end
          within '#search-item-list' do
            expect(first('li')).to have_selector "img[src='#{item.remote_image_url}']"
            expect(first('li')).to have_content item.name
            expect(first('li')).to have_content item.genre
            first('li').click_on '追加'
          end
          expect(page).to have_content "#{item.name} をマイアイテムに追加しました"
          within "#my-item-#{user.items.last.id}" do
            expect(page).to have_selector "img[src='#{user.items.last.image.url}']"
            expect(page).to have_content item.name
            expect(page).to have_content item.genre
          end
        end.to change { user.items.count }.by(1)
      end
    end

    context 'アイテムが既に登録済みのとき' do
      let(:item) { create(:item, image: nil, user: user) }
      it 'ボタンが【登録済み】と表示されること' do
        visit user_items_path(user)
        product = [{ 'affiliateUrl' => Faker::Internet.url, 'mediumImageUrl' => item.remote_image_url, 'productName' => item.name, 'genreName' => item.genre }]
        search_items_mock = class_double(RakutenWebService::Ichiba::Product)
        allow(search_items_mock).to receive(:search)
        allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
        expect { search_items_mock.search }.not_to raise_error
        expect do
          within '.search-item-group' do
            click_on 'アイテムを追加する'
            fill_in 'keyword', with: item.name
            find('.input-group-append button').click
          end
          within '#search-item-list' do
            expect(first('li')).to have_selector "img[src='#{item.remote_image_url}']"
            expect(first('li')).to have_content item.name
            expect(first('li')).to have_content item.genre
            expect(first('li')).to have_button '登録済み', disabled: true
          end
        end.to change { user.items.count }.by(0)
      end
    end

    context 'アイテム追加の条件を満たさないとき' do
      let(:item) { build(:item, name: nil, user: user) }
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
            first('li').click_on '追加'
          end
          expect(page).to have_content 'アイテムを追加することができませんでした'
        end.to change { user.items.count }.by(0)
      end
    end

    context 'キーワードを入力せずに直接アイテム検索ページへアクセスした場合' do
      it 'フラッシュメッセージが表示されること' do
        visit search_items_path
        expect(page).to have_content 'キーワードを入力して下さい'
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
