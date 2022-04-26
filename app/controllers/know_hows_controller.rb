class KnowHowsController < ApplicationController
  def index
    @know_hows = KnowHow.includes(:progresses).order(id: :asc)
  end

  def show
    @know_how = KnowHow.find(params[:id])
  end
end
