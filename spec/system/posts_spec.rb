require 'rails_helper'

RSpec.describe '投稿機能', type: :system do
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '投稿詳細ページ' do
    context '投稿詳細ページへ遷移したとき' do
      let(:user) { create(:user) }
      let(:post) { create(:post, user: user) }
      it '保存されている内容が表示されていること' do
        visit post_path(post)
        within '.card' do
          expect(page).to have_content post.user_name
          expect(page).to have_content post.content
          expect(page).to have_content post.tags[0].name
          expect(page).to have_content post.categories[0].name
          expect(page).to have_selector("img[src='#{post.photos[0].image.url}']")
        end
      end
    end
  end

  describe '新規投稿フォーム' do
    let(:user) { create(:user) }
    let(:post) { build(:post, user: user) }
    before do
      FactoryBot.rewind_sequences
      create_list(:tag, 3)
      create_list(:category, 3)
      visit current_path
    end

    context '入力内容が条件を満たすとき' do
      it '新しい投稿が作成されること', js: true do
        expect do
          within '.navbar' do
            click_on '投稿する'
          end
          within '.modal-content' do
            fill_in 'キャプション', with: post.content
            attach_file('post_form[images][]', Rails.root.join('spec/fixtures/test.jpg'), make_visible: true)
            find('label', text: 'タグ1').click
            find('label', text: 'カテゴリ1').click
            find('#new-button').click
          end
          expect(page).to have_current_path posts_path
          expect(page).to have_content '投稿しました'
        end.to change { user.posts.count }.by(1)
      end
    end

    context '未入力の項目があるとき' do
      it 'エラーメッセージが表示され、新しい投稿が作成されないこと', js: true do
        expect do
          within '.navbar' do
            click_on '投稿する'
          end
          find('#new-button').click
          expect(page).to have_content '※ キャプションを入力してください'
          expect(page).to have_content '※ 画像を選択して下さい'
          expect(page).to have_content '※ タグを選択してください'
          expect(page).to have_content '※ カテゴリーを選択してください'
        end.to change { user.posts.count }.by(0)
      end
    end

    context 'タグ・カテゴリが3つ以上選択されているとき' do
      it 'エラーメッセージが表示され、新しい投稿が作成されないこと', js: true do
        expect do
          within '.navbar' do
            click_on '投稿する'
          end
          within '.modal-content' do
            fill_in 'キャプション', with: post.content
            attach_file('post_form[images][]', Rails.root.join('spec/fixtures/test.jpg'), make_visible: true)
            find('label', text: 'タグ1').click
            find('label', text: 'タグ2').click
            find('label', text: 'タグ3').click
            find('label', text: 'カテゴリ1').click
            find('label', text: 'カテゴリ2').click
            find('label', text: 'カテゴリ3').click
            find('#new-button').click
          end
          expect(page).to have_content '※ タグは2つまで選択できます'
          expect(page).to have_content '※ カテゴリは2つまで選択できます'
        end.to change { user.posts.count }.by(0)
      end
    end
  end

  describe '投稿編集フォーム' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    before do
      FactoryBot.rewind_sequences
      create_list(:tag, 2)
      create_list(:category, 2)
    end

    context '入力内容が条件を満たすとき' do
      let(:updated_post) { build(:post) }
      it '内容が更新されること', js: true do
        visit post_path(post)
        find('#dropdownMenuButton').click
        click_on '編集'
        within '.modal-content' do
          # 更新前の内容を確認
          expect(page).not_to have_field 'キャプション', with: updated_post.content
          expect(page).not_to have_selector("img[src$='test_2.jpg']", visible: :all)
          expect(page).to have_unchecked_field('タグ1', visible: :hidden)
          expect(page).to have_unchecked_field('カテゴリ1', visible: :hidden)
          # 内容の更新
          fill_in 'キャプション', with: updated_post.content
          attach_file('post_form[images][]', Rails.root.join('spec/fixtures/test_2.jpg'), make_visible: true)
          find('label', text: 'タグ1').click
          find('label', text: 'カテゴリ1').click
          find('#edit-button').click
        end
        # 更新後の内容を確認
        within '.card' do
          expect(page).to have_content updated_post.content
          expect(page).to have_selector("img[src$='test_2.jpg']", visible: :all)
          expect(page).to have_content 'タグ1'
          expect(page).to have_content 'カテゴリ1'
        end
      end
    end

    context '未入力の項目があるとき' do
      it 'エラーメッセージが表示され、内容が更新されないこと', js: true do
        visit post_path(post)
        find('#dropdownMenuButton').click
        click_on '編集'
        fill_in 'キャプション', with: ''
        within '.modal-content' do
          find('label', text: post.tags[0].name).click
          find('label', text: post.categories[0].name).click
          find("div[data-id='photos-#{post.photos[0].id}'] .delete-preview").click
          find('#edit-button').click
        end
        expect(page).to have_content '※ キャプションを入力してください'
        expect(page).to have_content '※ タグを選択してください'
        expect(page).to have_content '※ カテゴリーを選択してください'
        expect(page).to have_content '※ 画像を選択して下さい'
      end
    end

    context 'タグ・カテゴリが3つ以上選択されているとき' do
      it 'エラーメッセージが表示され、内容が更新されないこと', js: true do
        visit post_path(post)
        find('#dropdownMenuButton').click
        click_on '編集'
        within '.modal-content' do
          find('label', text: 'タグ1').click
          find('label', text: 'タグ2').click
          find('label', text: 'カテゴリ1').click
          find('label', text: 'カテゴリ2').click
          find('#edit-button').click
        end
        expect(page).to have_content '※ タグは2つまで選択できます'
        expect(page).to have_content '※ カテゴリは2つまで選択できます'
      end
    end
  end
end
