class KnowHowsController < ApplicationController
  def index
    @know_hows = KnowHow.order(id: :asc)
  end

  def show; end
end
