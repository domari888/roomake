module Confirmable
  extend ActiveSupport::Concern

  included do
    validates :submitted, acceptance: true
    validates :confirmed, acceptance: true
    after_validation :confirming

    private

    def confirming
      # 確認ボタン押下した際に、入力エラーが無い場合
      self.submitted = '1' if submitted == '' && errors.keys == [:submitted]
      # 戻るボタンを押下した場合
      self.submitted = '' if confirmed == ''

      errors.delete :submitted
      errors.delete :confirmed
    end
  end
end
