class InquiriesController < ApplicationController
  def index
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.user_email(@inquiry).deliver_now
      InquiryMailer.admin_email(@inquiry).deliver_now
      if user_signed_in?
        redirect_to posts_path, notice: 'お問い合わせ内容を送信しました'
      else
        redirect_to root_path, notice: 'お問い合わせ内容を送信しました'
      end
    else
      render :index
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :name_kana, :email, :content, :submitted, :confirmed).merge(remote_ip: request.remote_ip)
  end
end
