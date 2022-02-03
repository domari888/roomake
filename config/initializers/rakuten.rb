RakutenWebService.configure do |c|
  # アプリケーションID
  c.application_id = Rails.application.credentials.rws[:RWS_APPLICATION_ID]

  # 楽天アフィリエイトID
  c.affiliate_id = Rails.application.credentials.rws[:RWS_AFFILIATE_ID]

  # リクエストのリトライ回数
  # 一定期間の間のリクエスト数が制限を超えた時、APIはリクエスト過多のエラーを返す。
  # その後、クライアントは少し間を空けた後に同じリクエストを再度送る。
  c.max_retries = 3 # default: 5

  # デバッグモード
  # trueの時、クライアントはすべてのHTTPリクエストとレスポンスを
  # 標準エラー出力に流す。
  c.debug = true # default: false
end
