require 'rails_helper'

RSpec.describe "Graphs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/graphs/index"
      expect(response).to have_http_status(:success)
    end
  end

end
