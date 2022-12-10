require 'rails_helper'

RSpec.describe 'アイテム機能', type: :system do
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    visit user_items_path(user)
  end

  describe 'マイアイテム一覧機能' do
    let(:user) { create(:user) }
    before do
      @item = create(:item, user: user)
    end

    context 'マイアイテムページへ遷移したとき' do
      it '登録済みのアイテムが表示されること' do
        visit user_items_path(user)
        within "#my-item-#{@item.id}" do
          expect(page).to have_selector "img[src='#{@item.image.url}']"
          expect(page).to have_content @item.name
          expect(page).to have_content @item.genre
        end
      end
    end
  end

  describe 'アイテム追加機能' do
    let(:user) { create(:user) }
    context '検索したアイテムの追加ボタンを押下したとき' do
      let(:item) { build(:item, user: user) }
      it 'そのアイテムがマイアイテムに追加されること', js: true do
        visit user_items_path(user)
        product = [{
          'affiliateUrl' => Faker::Internet.url,
          'mediumImageUrl' => item.remote_image_url,
          'productName' => item.name,
          'genreName' => item.genre,
          'productId' => Faker::Number.number,
          'id' => Faker::Number.number
        }]
        search_items_mock = class_double(RakutenWebService::Ichiba::Product)
        allow(search_items_mock).to receive(:search)
        allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
        expect { search_items_mock.search }.not_to raise_error
        expect do
          fill_in 'keyword', with: item.name
          find('.input-group-append button').click
          within '#search-item-list' do
            expect(first('li')).to have_selector "img[src='#{item.remote_image_url}']"
            expect(first('li')).to have_content item.name
            expect(first('li')).to have_content item.genre
            first('li').click_on '追加'
          end
          expect(page).to have_content "#{item.name} を追加しました"
        end.to change { user.items.count }.by(1)
      end
    end

    context 'アイテムが既に登録済みのとき' do
      let(:item) { create(:item, image: nil, user: user) }
      it '削除ボタンが表示されること' do
        visit user_items_path(user)
        product = [{
          'affiliateUrl' => Faker::Internet.url,
          'mediumImageUrl' => item.remote_image_url,
          'productName' => item.name,
          'genreName' => item.genre,
          'productId' => Faker::Number.number,
          'id' => Faker::Number.number
        }]
        search_items_mock = class_double(RakutenWebService::Ichiba::Product)
        allow(search_items_mock).to receive(:search)
        allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
        expect { search_items_mock.search }.not_to raise_error
        expect do
          fill_in 'keyword', with: item.name
          find('.input-group-append button').click
          within '#search-item-list' do
            expect(first('li')).to have_selector "img[src='#{item.remote_image_url}']"
            expect(first('li')).to have_content item.name
            expect(first('li')).to have_content item.genre
            expect(first('li')).to have_content '削除'
          end
        end.not_to(change { user.items.count })
      end
    end

    context 'アイテム追加の条件を満たさないとき', js: true do
      let(:item) { build(:item, user: user) }
      it 'エラーが発生すること' do
        visit user_items_path(user)
        product = [{
          'affiliateUrl' => Faker::Internet.url,
          'mediumImageUrl' => item.remote_image_url,
          'productName' => nil,
          'genreName' => item.genre,
          'productId' => Faker::Number.number,
          'id' => Faker::Number.number
        }]
        search_items_mock = class_double(RakutenWebService::Ichiba::Product)
        allow(search_items_mock).to receive(:search)
        allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
        expect { search_items_mock.search }.not_to raise_error
        expect do
          fill_in 'keyword', with: item.name
          find('.input-group-append button').click
          within '#search-item-list' do
            first('li').click_on '追加'
          end
          expect(page).to have_content 'アイテム名を入力してください'
        end.not_to(change { user.items.count })
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
    let(:user) { create(:user) }
    before do
      @item = create(:item, user: user)
    end

    context 'マイアイテムページから削除したとき' do
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

    context 'アイテム検索ページから削除したとき' do
      it '削除ボタンから追加ボタンに切り替わること', js: true do
        visit user_items_path(user)
        product = [{
          'affiliateUrl' => Faker::Internet.url,
          'mediumImageUrl' => @item.remote_image_url,
          'productName' => @item.name,
          'genreName' => @item.genre,
          'productId' => Faker::Number.number,
          'id' => Faker::Number.number
        }]
        search_items_mock = class_double(RakutenWebService::Ichiba::Product)
        allow(search_items_mock).to receive(:search)
        allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
        expect { search_items_mock.search }.not_to raise_error
        expect do
          fill_in 'keyword', with: @item.name
          find('.input-group-append button').click
          within '#search-item-list' do
            expect(first('li')).to have_content '削除'
            first('li').click_on '削除'
            expect(first('li')).to have_content '追加'
          end
          expect(page).to have_content "#{@item.name} を削除しました"
        end.to change { user.items.count }.by(-1)
      end
    end
  end
end
