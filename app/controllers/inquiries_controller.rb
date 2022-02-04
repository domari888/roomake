class InquiriesController < ApplicationController
  def index
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.user_email(@inquiry).deliver_now
      InquiryMailer.admin_email(@inquiry).deliver_now
      redirect_to posts_path, notice: 'お問い合わせが完了しました'
    else
      render :index
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :name_kana, :email, :content).merge(remote_ip: request.remote_ip)
  end
end
