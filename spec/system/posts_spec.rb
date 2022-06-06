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
        expect(page).to have_content post.user_name
        expect(page).to have_content post.content
        post.photos.each do |post|
          expect(page).to have_selector "img[src='#{post.image.url}']"
        end
        post.tags.each do |tag|
          expect(page).to have_content tag.name
        end
        post.categories.each do |category|
          expect(page).to have_content category.name
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
          find('.navbar-toggler').click
          within '.navbar-collapse' do
            click_on '投稿する'
          end
          fill_in 'キャプション', with: post.content
          attach_file('post_form[image][]', Rails.root.join('spec/fixtures/test.jpg'), make_visible: true)
          within '.tag-group' do
            all('label')[0].click
          end
          within '.category-group' do
            all('label')[0].click
          end
          find('#new-button').click
          expect(page).to have_current_path posts_path
          expect(page).to have_content '投稿しました'
        end.to change { user.posts.count }.by(1)
      end
    end

    context '未入力の項目があるとき' do
      it 'エラーメッセージが表示され、新しい投稿が作成されないこと', js: true do
        expect do
          find('.navbar-toggler').click
          within '.navbar-collapse' do
            click_on '投稿する'
          end
          expect(page).to have_button '投稿する', disabled: true
          attach_file('post_form[image][]', Rails.root.join('spec/fixtures/test.jpg'), make_visible: true)
          find('#new-button').click
          expect(page).to have_content '* 投稿内容を入力してください'
          expect(page).to have_content '* タグを選択してください'
          expect(page).to have_content '* カテゴリーを選択してください'
        end.to change { user.posts.count }.by(0)
      end
    end

    context 'タグ・カテゴリが3つ以上選択されているとき' do
      it 'エラーメッセージが表示され、新しい投稿が作成されないこと', js: true do
        expect do
          find('.navbar-toggler').click
          within '.navbar-collapse' do
            click_on '投稿する'
          end
          fill_in 'キャプション', with: post.content
          attach_file('post_form[image][]', Rails.root.join('spec/fixtures/test.jpg'), make_visible: true)
          within '.tag-group' do
            all('label')[0].click
            all('label')[1].click
            all('label')[2].click
          end
          within '.category-group' do
            all('label')[0].click
            all('label')[1].click
            all('label')[2].click
          end
          find('#new-button').click
          expect(page).to have_content '* タグは2つまで選択できます'
          expect(page).to have_content '* カテゴリは2つまで選択できます'
        end.to change { user.posts.count }.by(0)
      end
    end
  end

  describe '投稿編集フォーム' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    before do
      FactoryBot.rewind_sequences
    end

    context '入力内容が条件を満たすとき' do
      let(:updated_post) { build(:post) }
      before do
        @tag = create(:tag)
        @category = create(:category)
      end

      it '内容が更新されること', js: true do
        visit post_path(post)
        find('#dropdownMenuButton').click
        click_on '編集'
        within '.modal-content' do
          # 更新前の内容を確認
          expect(page).to have_field 'キャプション', with: post.content
          post.photos.each do |post|
            expect(page).to have_selector "img[src='#{post.image.url}']"
          end
          post.tags.each do |tag|
            expect(page).to have_checked_field(tag.name, visible: :hidden)
          end
          post.categories.each do |category|
            expect(page).to have_checked_field(category.name, visible: :hidden)
          end
          expect(page).to have_unchecked_field(@tag.name, visible: :hidden)
          expect(page).to have_unchecked_field(@category.name, visible: :hidden)
          # 内容の更新
          fill_in 'キャプション', with: updated_post.content
          attach_file('post_form[image][]', Rails.root.join('spec/fixtures/test_2.jpg'), make_visible: true)
          find("label[for='edit_post_form_tag_ids_#{@tag.id}']").click
          find("label[for='edit_post_form_category_ids_#{@category.id}']").click
        end
        find('#edit-button').click
        expect(page).to have_content updated_post.content
        expect(page).to have_selector("img[src$='test_2.jpg']", visible: :all)
        expect(page).to have_content @tag.name
        expect(page).to have_content @category.name
      end
    end

    context '未入力の項目があるとき' do
      it 'エラーメッセージが表示され、内容が更新されないこと', js: true do
        visit post_path(post)
        expect do
          find('#dropdownMenuButton').click
          click_on '編集'
          fill_in 'キャプション', with: ''
          within '.modal-content' do
            post.tag_ids.each do |id|
              find("label[for='edit_post_form_tag_ids_#{id}']").click
            end
            post.category_ids.each do |id|
              find("label[for='edit_post_form_category_ids_#{id}']").click
            end
          end
          find('#edit-button').click
          expect(page).to have_content '* 投稿内容を入力してください'
          expect(page).to have_content '* タグを選択してください'
          expect(page).to have_content '* カテゴリーを選択してください'
          post.photo_ids.each do |id|
            find("div[data-id='photos-#{id}'] button").click
          end
          expect(page).to have_button '投稿する', disabled: true
        end.to change { user.posts.count }.by(0)
      end
    end

    context 'タグ・カテゴリが3つ以上選択されているとき' do
      before do
        @tags = create_list(:tag, 2)
        @categories = create_list(:category, 2)
      end

      it 'エラーメッセージが表示され、内容が更新されないこと', js: true do
        visit post_path(post)
        expect do
          find('#dropdownMenuButton').click
          click_on '編集'
          within '.modal-content' do
            @tags.each do |tag|
              find("label[for='edit_post_form_tag_ids_#{tag.id}']").click
            end
            @categories.each do |category|
              find("label[for='edit_post_form_category_ids_#{category.id}']").click
            end
          end
          find('#edit-button').click
          expect(page).to have_content '* タグは2つまで選択できます'
          expect(page).to have_content '* カテゴリは2つまで選択できます'
        end.to change { user.posts.count }.by(0)
      end
    end
  end
end
