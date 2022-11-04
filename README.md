# Roomake
アプリ名の「**Roomake**(ルーメイク)」は部屋を意味する「Room」と作るを意味する「Make」を掛け合わせて命名しました。
トップページのサブタイトルにもあるように、理想のおうちで素敵なじかんを過ごす為に「**Room(部屋意外にも家の好きなところ)** の **Make(理想を作り上げていく)** をする」という想いを込めています。
  
- **URL** : https://roomake.herokuapp.com
  
### トップページ
<img height="400px" alt="トップページ(pc)スクリーンショット" src="https://user-images.githubusercontent.com/81894935/190972135-1e9ae214-e286-4d72-894e-10bb58874a58.png"> <img height="400px" alt="トップページ(mobile)スクリーンショット" src="https://user-images.githubusercontent.com/81894935/190972170-69f254ff-7a15-46aa-9057-84a0d70cc86b.png">
  
<br>
  
## アプリ概要
主な機能としては、画像付き投稿機能を使って自分の"おうち"をシェアしたり、理想の"おうち"を見つけたりするアプリです。  
- 投稿を作成・削除・編集・検索・いいね・マークをする事が出来る。
- 家具・家電を検索してマイアイテムとして登録する事が出来る。
- 引越しの際のノウハウをチェックシートにて記録する事が出来る。
- 人気のタグ・カテゴリやいいね獲得数のランキングなどを確認する事が出来る。
  
<br>
  
## コンセプト
「こんな家に住みたい！」、「この家具・家電欲しい！」 を見つける"おうち"に特化したアプリ。  
引っ越しや家づくりの際に経験した成功・失敗エピソード、使っているおすすめ家具・家電の紹介などの情報を投稿・検索することで、様々な視点からの情報を知る事が出来るような、引っ越しの際や家づくりの際に役立つ”辞書”になるアプリにする。
  
<br>
  
## 機能一覧
|  | 機能 | 詳細 | 使用技術, gem |
| -- | -- | -- | -- |
| 1 | アカウント関連機能 | アカウント登録・削除・編集機能 | devise |
| 2 | ユーザー認証関連機能 | ログイン・ログアウト機能<br>ゲストログイン機能 | devise |
| 3 | 投稿関連機能 | 新規投稿・投稿削除・投稿編集<br>投稿一覧表示機能<br>投稿詳細表示機能 | - |
| 4 | 投稿検索機能 | キーワード・タグ・カテゴリ別での検索機能 | ransack |
| 5 | コメント関連機能 | コメント追加・削除機能 | - |
| 6 | いいね機能 | - | - |
| 7 | マーク機能 | - | - |
| 8 | アイテム関連機能 | アイテム検索機能<br>マイアイテム追加・削除機能<br>商品ページへのリンク機能 | rakuten_web_service |
| 9 | ノウハウ関連機能 | ノウハウチェック機能<br>ノウハウ一覧表示機能<br>ノウハウ詳細表示機能 | - |
| 10 | ランキング機能 | タグ別使用投稿数<br>カテゴリ別使用投稿数<br>いいね総合獲得数<br>平均いいね獲得数 | chartkick |
| 11 | ユーザーページ機能 | 投稿一覧表示<br>いいね済みの投稿一覧表示<br>マーク済みの投稿一覧表示<br>アイテム一覧表示 | - |
| 12 | 画像アップロード機能　| 投稿画像選択<br>プロフィール画像選択 | carrierwave, mini_magick, fog-aws, AWS S3, CloudFront |
| 13 | お問い合わせ機能 | - | ActionMailer |
| 14 | 管理者機能 | - | activeadmin |
  
<br>
  
## ER図
![roomake](https://user-images.githubusercontent.com/81894935/192044593-e6003d45-c66b-47dc-a798-33e882cc5f25.svg)
  
<br>
  
## 使用技術
- フロントエンド
  - HTML / CSS / Sass
  - JavaScript / jQuery
  - Bootstrap
- バックエンド
  - Ruby
  - Ruby on Rails
- インフラ
  - Heroku
  - AWS(S3, IAM, CloudFront)
- DB
  - PostgreSQL
- テスト
  - RSpec
- 主要gem
  - devise
  - carrierwave
  - mini_magick
  - fog-aws
  - kaminari
  - ransack
  - chartkick
  - rakuten_web_service
  - gon
  - enum_help
- 開発環境 / その他関連ツール
  - macOS Big Sur
  - VScode
  - Git / GitHub
  
<br>
  
## このアプリで出来る事
### 1. アカウント登録・編集・削除
`devise`を使用してアカウント機能を実装しています。
  
会員登録ページから「プロフィール画像」、「ユーザーネーム」、「メールアドレス」、「パスワード」、「年代」、「お住まい」、「家族構成」を入力して、「利用規約」について同意する事で、アカウント登録する事が出来ます。
「プロフィール画像」は、任意で登録する事が出来るようにしています。

| アカウント登録 |
| :---: |
| <img width="70%" alt="アカウント登録_画面収録_2022-09-24" src="https://user-images.githubusercontent.com/81894935/192101626-107ebb18-a0f6-4de3-a4a8-c81173f3f1fe.gif"> |
  
マイページの【プロフィール編集】を選択して、編集ページから登録した内容を編集・削除する事が出来ます。
アカウント編集 | アカウント削除 |
| --- | --- |
| ![アカウント編集_画面収録_2022-09-24](https://user-images.githubusercontent.com/81894935/192087478-eb62e37d-53aa-4b37-9c5d-818f88f427df.gif) | ![アカウント削除_画面収録_2022-09-24](https://user-images.githubusercontent.com/81894935/192087712-445f68c7-0455-4314-9bdb-e8d561da7348.gif) |
  
<br>
  
### 2. ユーザー認証
`devise`を使用してログイン・ログアウト機能を実装しています。
  
#### ログイン
アカウントが登録済みの場合は、ログインページから「メールアドレス」、「パスワード」を入力することでログインする事が出来ます。ナビバーの【ログアウト】からログアウトする事が出来ます。
  
| ログイン | ログアウト　|
| --- | --- |
| ![ログイン_画面収録_2022-09-24](https://user-images.githubusercontent.com/81894935/192383192-b4b0fcc2-0eb8-4e17-897b-08a978a7e95a.gif) | ![ログアウト_画面収録_2022-09-24](https://user-images.githubusercontent.com/81894935/192382670-a1b65f7f-ad8f-457a-b23b-6e7226d2fd49.gif) |
  
<br>

### 3. ゲストログイン機能
`devise`を使用してゲストログイン機能を実装しています。トップページまたはナビバーの【ゲストログイン】から簡単ログイン出来るようにしており、ゲストユーザーとして**実際にアプリの閲覧や機能を試せる**ようにしています。
  
<img width="49%" alt="ゲストログインボタン(上部)" src="https://user-images.githubusercontent.com/81894935/199669491-095a8851-7cf6-417b-be2e-e788cffc6bcc.png"> <img width="49%" alt="ゲストログインボタン(下部)" src="https://user-images.githubusercontent.com/81894935/199669510-23e8b18e-90d6-4375-aebe-75b93e79fe5c.png">
  
<br>

### ４. 新規投稿・投稿編集・投稿削除
ナビバーの【投稿する】から、「キャプション」、「画像」、「タグ」、「カテゴリ」を入力して投稿する事が出来ます。
  
主要機能となる新規投稿を全ページから投稿できるようにする為に、【投稿する】ボタンをナビバーに設置する事でパフォーマンス及びUXの向上に繋げています。
  
| 新規投稿 |
| :---: |
| <img width="70%" alt="投稿追加_画面収録_2022-09-25" src="https://user-images.githubusercontent.com/81894935/192101626-107ebb18-a0f6-4de3-a4a8-c81173f3f1fe.gif"> |
  
投稿詳細ページの【⚙︎ ▾】ボタンから投稿を編集・削除する事が出来ます。
  
| 編集 | 削除 |
| --- | --- |
| ![投稿編集_画面収録_2022-09-27](https://user-images.githubusercontent.com/81894935/192380236-f72755f0-001b-47ba-9372-6fd1272b0964.gif) | ![投稿削除_画面収録_2022-09-27](https://user-images.githubusercontent.com/81894935/192378217-348773d7-3d9d-4873-89e1-96e004682a34.gif) |
  
<br>
  
### 5. 投稿検索
ナビバーの【検索する】から「キーワード」、「タグ」、「カテゴリ」を選択して条件検索を行う事が出来ます。「キーワード」の場合はユーザーネーム、キャプションから部分一致する全ての投稿を、「タグ」と「カテゴリ」の場合は選択したものを含む全ての投稿の検索を行います。いずれも入力しない場合は全件検索を行います。
  
こちらも全ページから検索できるようにする為に、【検索】ボタンをナビバーに設置する事でパフォーマンス及びUXの向上に繋げています。
  
<img width="70%" alt="投稿検索_画面収録_2022-09-27" src="https://user-images.githubusercontent.com/81894935/192377367-c7dc4c67-6066-4cb4-b018-8c8e7df638b0.gif">
  
<br>

### 6. コメント追加・削除
投稿詳細ページの【コメント...】フォームからコメントする事が出来ます。  
コメントを削除したい場合、自分のしたコメントには【×】ボタンを表示しており、それをクリックすることで「コメント」を削除する事が出来ます。
  
パフォーマンス及びUXを向上させる為に、コメントの追加・削除の処理には非同期通信を使用しており、そのコメント１件のみを部分テンプレートを使用して更新しています。
  
<img width="70%" alt="コメント機能_画面収録_2022-09-27" src="https://user-images.githubusercontent.com/81894935/192376192-d098e90b-3d60-4c8c-acd8-b97425dcc6c7.gif">

<br>

### 7. いいね・マーク機能
「いいね」、「マーク」はタイムラインページと詳細ページの両方から出来るようにしています。
  
投稿詳細ページへ遷移せずに「いいね」、「マーク」が出来る様にするかつ非同期通信を使用して切り替えることで、パフォーマンス及びUXの向上に繋げています。
  
また、マークした投稿は自分以外の他のユーザーは見る事が出来ない様になっており、後でまた閲覧したい投稿やお気に入りの投稿をいいねした投稿とは別にまとめる事が出来ます。
  
![いいね・マーク機能_画面収録_2022-09-27_1](https://user-images.githubusercontent.com/81894935/192375248-8353df6c-8c99-4d11-85cf-d2d870a4223e.gif)
  
<br>

### 8. アイテム追加・削除・検索
マイページの【マイアイテム】ボタン > マイアイテムページの【アイテムを追加する +】の検索窓から、キーワードを入力し検索する事が出来ます。`Rakuten Webservice`の「商品価格ナビ製品検索API」を使用してアイテム情報(製品画像、製品名、ジャンル名、製品ページへのURL)を取得し表示しています。表示されたアイテム画像を選択することで、楽天市場の製品詳細ページへ遷移できるようになっています。
  
表示されたアイテムの【追加】を選択する事で、マイアイテムに登録されます。
  
マイアイテムページの【⋯】ボタンから登録したマイアイテムを削除する事が出来ます。アイテム削除の処理には非同期通信を使用しており、選択されたアイテムの要素のみを削除する事で、パフォーマンス及びUXの向上に繋げています。
  
| アイテム検索 |　アイテム追加・削除　|
| --- | --- |
| ![アイテム検索_画面収録_2022-09-28](https://user-images.githubusercontent.com/81894935/192758814-84fd73a5-4cee-47b8-98ec-3feecb65fbcb.gif) | ![アイテム機能_画面収録_2022-09-28](https://user-images.githubusercontent.com/81894935/192758854-d3ceaf7a-dd78-4d13-b87b-493c6d0a3d07.gif) |
  
<br>

### 10. ノウハウ機能
ノウハウページでは私が引越しの際に「やっておいて良かった」と感じた事を厳選して、それを`ToDo`リスト形式で表示して「進捗状況」を確認出来る様にしています。
  
リストの項目は内容を簡潔に表示して、より詳細が知りたい項目は【詳細を見る】から「準備するもの」や「注意事項」などの内容を、モーダルを使用して表示して各リストの項目が見やすくなる様に工夫しています。
  
<img width="70%" alt="ノウハウ機能_画面収録_2022-09-27" src="https://user-images.githubusercontent.com/81894935/192420753-05869e89-8fb8-4b37-8090-52d4b024a458.gif">
  
<br>

### 11. お問い合わせ機能
お問い合わせページからお客様の「お名前」、「お客様のお名前(カナ)」、「メールアドレス」、「お問い合わせ内容」を入力してメールを送信する事が出来ます。
  
`Rails`の`ActionMailer`を使用して、ユーザーと管理者へのメールは`deliver_now`メソッドを使用したテキスト形式で送信しています。
  
<img width="70%" alt="お問い合わせ機能_画面収録_2022-09-27" src="https://user-images.githubusercontent.com/81894935/192440429-c18ceb91-1879-4248-92e7-cf7e077b4132.gif">
  
<br>
  
## 工夫した点
### 1. Form Object を使用して複数モデルのデータを保存・更新
新規投稿・編集フォームでは「キャプション(Post モデル)」、「画像(Photo モデル)」、「タグ(PostTag モデル)」、「カテゴリ(PostCategory モデル)」の複数モデルのデータを1つのフォームから同時に保存・更新する為に、`Form Object`を使用しました。
#### 投稿の保存・更新時のエラーメッセージを非同期で実装
新規投稿・編集ページはモーダルを使用して表示しているため、サーバー側でのバリデーションエラー発生時に入力値を保持したままレンダリングする事が難しくなってしまっています。その対応策として新規投稿・編集フォームを非同期処理で実装し、保存・更新に失敗した場合は、`js.erb`ファイルを使用してエラーメッセージの部分テンプレートをレンダリングして、モーダルを残したままエラーメッセージを非同期処理で表示しています。

#### 保存までの流れ
1. `PostForm`(Form Object)のインスタンスを生成し、引数に`ストロングパラメータ`、`current_user.id`、`@post`オブジェクトの値を渡す。`@post`オブジェクトには`create`アクションの時は`Post`モデルのインスタンスを、`edit`アクションの時は編集対象となる投稿のオブジェクトを渡しています。
2. `Form Object`の`save`メソッド内で`invalid?`メソッドを用いてバリデーションの検証を行う。ここでエラーが発生した場合は`errors`オブジェクトにエラーを追加して、モーダル内部に非同期処理でエラーメッセージを表示します。
3. バリデーション通過後、トランザクション内で実行するメソッドを、新規投稿か編集かで条件分岐。アクションの判断は受け取った`@post`オブジェクトが保存済みかどうかで判断しいています。
4. 【新規投稿の場合】
`post_create`メソッドを実行して、「キャプション」、「タグ」、「カテゴリ」、「ユーザーID」を引数に渡して`Post`モデルのインスタンスを作成。「画像」は1枚ずつ`build`して`save`して保存します。
【編集の場合】
`post_update`メソッドを実行して、削除する画像の`id`が渡された時、それと同じ`id`を持つ画像を`Photo`モデルから検索して削除。画像が選択された時、1枚ずつ`build`して`save`。この時に全ての画像が削除され1枚も選択されていない場合、例外を発生させてロールバックしています。画像の更新後、「キャプション」、「タグ」、「カテゴリ」を`update!`して更新しています。
5. 保存・更新に成功した場合は、フォーマットが`js`のため`JavaScript`を使用してページ遷移し、エラーが発生した場合は、`errors`オブジェクトにエラーを追加してモーダル内部に非同期処理でエラーメッセージを表示します。
  
【Form Object】
```rb:post_form.rb
class PostForm
  include ActiveModel::Model

  attr_accessor :content, :images, :post, :tag_ids, :category_ids, :delete_ids, :user_id

  validates :content, presence: true, length: { maximum: 2000 }
  validates :images, presence: true, on: :create
  validates :images, number_of_images: true

  # カスタムバリデーションを追加
  validates :tag_ids, presence: true, length: { maximum: 2, message: 'は最大2つまで選択できます' }, custom_numericality: { allow_blank: true }
  validates :category_ids, presence: true, length: { maximum: 2, message: 'は最大2つまで選択できます' }, custom_numericality: { allow_blank: true }

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      if post.persisted?
        post_update
      else
        post_create
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, message: e.record.errors.full_messages)
    false
  end

  private

  def post_update
    if delete_ids.present?
      delete_ids.each do |id|
        Photo.find(id.to_i).destroy!
      end
    end
    if images.present?
      images.each do |img|
        post.photos.build(image: img).save!
      end
    end
    raise ActiveRecord::Rollback unless post.photos.any?

    post.update!(content: content, tag_ids: tag_ids, category_ids: category_ids)
  end

  def post_create
    post = Post.new(content: content, user_id: user_id, tag_ids: tag_ids, category_ids: category_ids)
    return false if images.blank?

    images.each do |img|
      post.photos.build(image: img).save!
    end
  end
end
```
【コントローラの新規投稿・編集処理】
```rb:posts_controller.rb
# 投稿の保存・更新に必要な部分のみ抜粋

class PostsController < ApplicationController
  before_action :set_post, only: %i[update destroy]
  PER_PAGE = 20

  def create
    @post = Post.new
    @post_form = PostForm.new(post_params.merge(user_id: current_user.id, post: @post))
    if @post_form.save
      flash[:notice] = '投稿しました'
      # フォーマットが js のため JavaScript を使用してページ遷移
      render js: "window.location.replace('#{posts_path}');"
    else
      render :create_error_messages
    end
  end

  def update
    @post_form = PostForm.new(post_params.merge(user_id: current_user.id, post: @post))
    if @post_form.save
      flash[:notice] = '投稿を編集しました'
      # フォーマットが js のため JavaScript を使用してページ遷移
      render js: "window.location.replace('#{post_path(@post)}');"
    else
      render :update_error_messages
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, alert: '削除しました'
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post_form).permit(:content, images: [], tag_ids: [], category_ids: [], delete_ids: [])
  end
end
```
【新規投稿・編集フォームのエラーメッセージ部分】
```erb:_new_modal_content.erb
<%# エラーメッセージを表示する部分のみ抜粋 %>

<%= form_with model: PostForm.new, url: posts_path, class: 'post-form', namespace: 'new', local: false do |form| %>
  <div id="post-create-error-messages">
    <%= render "layouts/error_messages", model: form.object %>
  </div>
  <%# ~ 以下省略 ~ %>
<% end %>
```
```erb:_edit_modal_content.erb
<%# エラーメッセージを表示する部分のみ抜粋 %>

<%= form_with model: PostForm.new, url: post_path, class: 'post-form', method: :patch, namespace: 'edit', local: false do |form| %>
  <div id="post-update-error-messages">
    <%= render "layouts/error_messages", model: form.object %>
  </div>
  <%# ~ 以下省略 ~ %>
<% end %>
```
【エラーメッセージの部分テンプレートを切り替えるファイル】
```js:create_error_messages.js.erb
document.getElementById('post-create-error-messages').innerHTML = '<%= j render("layouts/error_messages", model: @post_form) %>';
document.getElementById('post-create-error-messages').scrollIntoView();
```
```js:update_error_messages.js.erb
document.getElementById('post-update-error-messages').innerHTML = '<%= j render("layouts/error_messages", model: @post_form) %>';
document.getElementById('post-update-error-messages').scrollIntoView();
```
  
<br>
  
### 2. 新規投稿・投稿検索機能を全ページで対応
新規投稿・投稿検索ページをモーダルで実装し、ヘッダーにモーダル起動ボタンを設置する事で全てのページから新規投稿・投稿検索を行える様にしています。主要機能ともなる投稿の作成・検索を全てのページから行えるようにする事で`UX`を向上させています。
  
<br>
  
### 3. 画像プレビュー機能
ユーザーが今画像を選択されているか否か直感的に分かるよう、即時プレビューを実装しました。
  
プレビューの表示の大まかな流れは
1. `FileReader`の`readAsDataURL()`メソッドで引数に渡した`File`オブジェクトを読み込む。
2. 取得した画像URLをプレビュー画像となる`img`要素の`src`属性に格納。
3. 削除ボタンと共にプレビュー要素として`HTML`に追加。
  
プレビューを削除する場合は、押下した削除ボタンを子要素にもつプレビュー要素を`remove()`メソッドで丸ごと削除しています。
  
| 投稿画像プレビュー表示・削除 | プロフィール画像プレビュー表示・削除 |
| --- | --- |
| ![画像アップロード_画面収録_2022-09-27](https://user-images.githubusercontent.com/81894935/192464497-06204ea6-5f91-4bf3-9e5e-7732fca59606.gif) | ![プロフィール画像アップロード_画面収録_2022-09-27](https://user-images.githubusercontent.com/81894935/192467058-e65086b6-fbc3-4040-a496-abb263d546c0.gif) |
  
<br>

### 4. レスポンシブ対応
近年では、スマートフォンでの web閲覧の割合が多いことからPC以外からのアクセスを考慮して、スクリーンサイズ別にレイアウトの表示を設定をしました。
  
<img width="70%" alt="レスポンシブ_画面収録_2022-09-27" src="https://user-images.githubusercontent.com/81894935/192428257-c4410fe1-2c59-48a2-abb6-281fd73ee478.gif">
  
<br>

### 5. UI/UX 関連
投稿やアイテムなどの一覧表示では、PCではページネーション、スマートフォンでは無限スクロールを使用して表示しています。
|　ページネーション　| 無限スクロール |
| --- | --- |
| ![ユーザーページ_画面収録_2022-09-27](https://user-images.githubusercontent.com/81894935/192462125-2bb7fddd-7256-4122-985d-4d6d6789b458.gif) | ![無限スクロール_アイテム_画面収録_2022-11-04](https://user-images.githubusercontent.com/81894935/199780445-4478d2bd-b6b9-4737-b0d9-0a80136a472a.gif) |
  
投稿詳細ページでは、各投稿の画像枚数の違いによる UI の差異を無くす為に、複数の投稿画像を限られた空間で表示する事が出来るスライド形式にしました。
  
ユーザーページでは、ページ遷移せずに3種類のコンテンツ(①自分の投稿、②いいねした投稿、③マークした投稿またはアイテム一覧)を限られた空間で表示する為に、タブメニューで表示しました。タブ表示にすることでコンテンツ全体を把握できるようになり、直感的に閲覧したいコンテンツへの切り替えを行えるようにしています。③の「マークした投稿またはアイテム一覧」の表示は、マイページではマークした投稿がスムーズに見れるようにタブメニューに「マーク一覧」表示して、その他ユーザーページではそのユーザーがどんな家具・家電を使っているのか閲覧できる様に「アイテム」を表示しています。
  
| カルーセル | マイページタブ |
| --- | --- |
| ![カルーセル_画面収録_2022-09-27](https://user-images.githubusercontent.com/81894935/192433320-f4dff5bb-6b56-4146-9cf7-4dea48d7fdce.gif) | ![マイページ_画面収録_2022-09-27](https://user-images.githubusercontent.com/81894935/192446261-edadf043-a644-421d-a6f2-164cf1c46fa7.gif) |
  
<br>

### 9. バリデーション
新規投稿・編集フォームではフロント側で入力必須とするために`required`属性を設定してしまうと、「タグ」、「カテゴリ」選択の際に全てを選択しなければいけなくなってしまうため、`jQuery Validation Plugin`を使用して1つ選択する事で、バリデーションを通過するように実装しました。
  
<br>
  
### 10. 非同期通信
`form_with`メソッドには`local: false`を、`link_to`メソッドには`remote: true`オプションを追加し、`js.erb`ファイルを使用して部分更新しています。
  
| 機能 | 詳細 |
| --- | --- |
| コメント追加 | 新規コメントを既存のコメントの手前に挿入し、その後コメントフォームを空にしています。 |
| コメント削除 | 指定したコメント要素を丸ごと削除しています。 |
| いいね・マーク・ノウハウチェック| 表示するアイコンの部分テンプレートを切り替えています。 |
| アイテム再検索　| 新しいアイテム一覧の部分テンプレートに書き換えています。 |
| アイテム削除| 指定したアイテム要素を丸ごと削除しています。 |
| アイテム表示 | 表示するユーザーアイテムのページを切り替えています。 |
  
<br>
  
## 苦戦したところ
### 1. 投稿画像の削除
プレビューを削除するだけでは新規投稿・編集ページの画像選択で読み取った`File`オブジェクトの削除や 編集ページで保存済みの画像を DB から削除する事ができません。さらにドラッグ&ドロップにも対応する為に`DataTransfer`オブジェクトを使用しているため、`input`要素の`FileList`オブジェクトとドラッグ&ドロップの`DataTransfer`オブジェクトの両方から削除しないと保存・更新時にデータが保持されてしまい削除されないままになってしまう為、どう削除するか苦戦しました。
  
#### 対応策
1. 新規投稿・編集ページにて画像フィールドに追加された画像(選択した`File`オブジェクト)、または編集ページにて保存済みの画像(DB に保存されている画像)のどれを削除するのか判別する為に、押下した削除ボタンの親要素が持つ`data-id`属性を取得。
```js
const targetImage = $(this).parents("[class$='preview-item']");
const targetId = $(targetImage).data('id');
```
2. 削除する画像が画像フィールドに追加された画像の場合は、取得した`data-id`属性の値と一致するインデックスの`DataTransferItemsList`オブジェクトを削除 > `input`要素の`FileList`オブジェクトに`DataTransfer`オブジェクトの`files`プロパティ(`FileList`オブジェクト) を代入する。
```js
$.each(fileField.files, function(i, file){
  if(file.id === targetId){
    dataBox.items.remove(i);
    fileField.files = dataBox.files;
    return false;
  }
});
```
保存済の画像の場合は`post_params[:delete_ids]`に取得した`data-id`属性を渡す > DB から`post_params[:delete_ids]`に渡された値と同じ`id`の画像を削除
```js
$('#edit-drop').before(`<input type="hidden" name="post_form[delete_ids][]" value="${targetId}">`);
```
  
とすることで、「`input`要素の`FileList`オブジェクト」、「ドラッグ&ドロップの`DataTransfer`オブジェクト」、「その投稿に保存されている画像データ」の全てで差異をなくしています。
  
```js
//投稿画像削除のコード抜粋 ↓

let editDataBox = new DataTransfer();
let edit_file_field = document.querySelector('input[data-action=edit]');
let newDataBox = new DataTransfer();
let new_file_field = document.querySelector('input[data-action=new]');

$('.preview-box').on("click", '.delete-preview', function(){
  let dataBox, fileField;
  const action = $(this).data('action');
  if (action === "edit") {
    dataBox = editDataBox
    fileField = edit_file_field
  } else {
    dataBox = newDataBox
    fileField = new_file_field
  }
  const targetImage = $(this).parents("[class$='preview-item']");
  const targetId = $(targetImage).data('id');
  if($(targetImage).hasClass('preview-item')){
    $.each(fileField.files, function(i, file){
      if(file.id === targetId){
        dataBox.items.remove(i);
        fileField.files = dataBox.files;
        return false;
      }
    });
  }else{
    $('#edit-drop').before(`<input type="hidden" name="post_form[delete_ids][]" value="${targetId}">`);
  }
  targetImage.remove();
});
```
  
<br>
  
### 2. システムスペック
システムスペックはアプリ作成まで一度も書いた事がなく、調べながらの実装だったので何度も躓き苦戦しました。その中でも、外部API を使用した場合のテストではモックやテストダブルなどを使用して、実際にAPIが動作しないように擬似メソッドを使用したテストの作成が必要で、実装に一番苦戦しました。
  
考え方としては
1. 戻り値の配列を定義する。
2. `RakutenWebService::Ichiba::Product`クラス自体をモックする為に`class_double`メソッドでモックを作成する。
3. 作成したモックが`RakutenWebService::Ichiba::Product`クラスの`search`メソッドを呼び出せるようにする。
4. `RakutenWebService::Ichiba::Product`クラスの`search`メソッドが呼ばれたら定義した戻り値を返すようにする。
  
として、外部API を呼び出さずにテストを実装しました。
  
```ruby
# コード一部抜粋 ↓

product = [{ 'affiliateUrl' => Faker::Internet.url, 'mediumImageUrl' => item.remote_image_url, 'productName' => item.name, 'genreName' => item.genre }]
search_items_mock = class_double(RakutenWebService::Ichiba::Product)
allow(search_items_mock).to receive(:search)
allow(RakutenWebService::Ichiba::Product).to receive(:search).and_return(product)
expect { search_items_mock.search }.not_to raise_error
```
  
<br>

## チーム開発を意識したタスク管理
実務を意識した環境下での開発をする為に、以下のことを実施しました。
- 各タスク毎に`issue`を作成
- `Projects`を作成して`issue`を管理
- `Git-flow`に従ったブランチの作成
- 適切な粒度でのコミット、プルリクエスト
- コミットメッセージは1行目に要約、3行目に詳細を下記分かりやすくする
- `GitHub`上でのレビュー、マージ、クローズ
