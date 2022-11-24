crumb :root do
  link 'トップページ', root_path
end

crumb :sign_in do
  link 'ログイン', new_user_session_path
  parent :root
end

crumb :sign_up do
  link '会員登録'
  parent :root
end

crumb :password_reissue do
  link 'パスワード再発行'
  parent :sign_in
end

crumb :user_show do |user|
  if user == current_user
    link 'マイページ', user_path(user)
  else
    link user.name, user_path(user)
  end
  parent :root
end

crumb :user_edit do |user|
  link '編集'
  parent :user_show, user
end

crumb :items do |user|
  link item_page_title(user)[:sub_title], user_items_path(user)
  parent :user_show, user
end

crumb :item_search do
  if (keyword = params[:keyword].presence)
    link "#{keyword} の検索結果"
    parent :items, current_user
  else
    link 'アイテム検索', search_items_path
    parent :root
  end
end

crumb :posts_index do
  link 'タイムライン', posts_path
  parent :root
end

crumb :post_show do |post|
  link "#{post.user_name} の投稿"
  parent :posts_index
end

crumb :data do
  link 'データ'
  parent :root
end

crumb :know_hows do
  link 'ノウハウ'
  parent :root
end

crumb :inquiry do
  link 'お問い合わせ'
  parent :root
end

crumb :terms_of_use do
  link '利用規約'
  parent :root
end

crumb :privacy_policy do
  link 'プライバシーポリシー'
  parent :root
end
