class ProgressesController < ApplicationController
  before_action :set_know_how, only: %i[create destroy]

  def create
    current_user.progresses.create!(know_how_id: @know_how.id)
  end

  def destroy
    current_user.progresses.find_by(know_how_id: @know_how.id).destroy!
  end

  private

  def set_know_how
    @know_how = KnowHow.find(params[:know_how_id])
  end
end
