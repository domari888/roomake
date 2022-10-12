require 'rails_helper'

RSpec.describe 'お問い合わせ機能', type: :system do
  let(:inquiry) { build(:inquiry) }
  before do
    visit root_path
    first('footer').click_on 'お問い合わせ'
    fill_in 'お客様のお名前', with: inquiry.name
    fill_in 'お客様のお名前(カナ)', with: inquiry.name_kana
    fill_in 'メールアドレス', with: inquiry.email
    fill_in 'お問い合わせ内容', with: inquiry.content
  end

  describe '入力画面' do
    context '入力内容が条件を満たすとき' do
      it '確認画面に遷移し、入力した内容が表示されていること' do
        expect do
          expect(find('#inquiry_submitted', visible: false).value).to be_nil
          click_on '入力内容を確認'
          expect(find('#inquiry_submitted', visible: false).value).to eq '1'
          expect(find_field('お客様のお名前').readonly?).to be true
          expect(find_field('お客様のお名前').value).to eq inquiry.name
          expect(find_field('お客様のお名前(カナ)').readonly?).to be true
          expect(find_field('お客様のお名前(カナ)').value).to eq inquiry.name_kana
          expect(find_field('メールアドレス').readonly?).to be true
          expect(find_field('メールアドレス').value).to eq inquiry.email
          expect(find_field('お問い合わせ内容').readonly?).to be true
          expect(find_field('お問い合わせ内容').value).to eq inquiry.content
        end.not_to change(Inquiry, :count)
      end
    end
  end

  describe '確認画面' do
    context '【入力画面に戻る】ボタンを押下したとき' do
      it '入力画面に遷移し、入力した内容が表示されていること' do
        expect do
          expect(find('#inquiry_submitted', visible: false).value).to be_nil
          click_on '入力内容を確認'
          click_on '入力画面に戻る'
          expect(find('#inquiry_submitted', visible: false).value).to eq ''
          expect(find_field('お客様のお名前').readonly?).to be false
          expect(find_field('お客様のお名前').value).to eq inquiry.name
          expect(find_field('お客様のお名前(カナ)').readonly?).to be false
          expect(find_field('お客様のお名前(カナ)').value).to eq inquiry.name_kana
          expect(find_field('メールアドレス').readonly?).to be false
          expect(find_field('メールアドレス').value).to eq inquiry.email
          expect(find_field('お問い合わせ内容').readonly?).to be false
          expect(find_field('お問い合わせ内容').value).to eq inquiry.content
        end.not_to change(Inquiry, :count)
      end
    end

    context '【この内容で送信する】ボタンを押下したとき' do
      it '入力した内容が保存されること' do
        expect do
          expect(find('#inquiry_submitted', visible: false).value).to be_nil
          click_on '入力内容を確認'
          click_on 'この内容で送信する'
          expect(page).to have_content 'お問い合わせ内容を送信しました'
        end.to change(Inquiry, :count).by(1)
      end
    end
  end
end
