module Confirmable
  extend ActiveSupport::Concern

  included do
    validates :submitted, acceptance: true
    validates :confirmed, acceptance: true
    after_validation :confirming

    private

    def confirming
      # 確認ボタン押下して入力エラーが無い場合
      if submitted == '' && errors.keys == [:submitted]
        self.submitted = '1'
        errors.delete :submitted
      end
      # 戻るボタンを押下した場合
      return unless confirmed == ''

      self.submitted = ''
      errors.delete :confirmed
    end
  end
end
