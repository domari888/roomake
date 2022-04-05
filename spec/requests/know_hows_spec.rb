require 'rails_helper'

RSpec.describe 'KnowHows', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/know_hows/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/know_hows/show'
      expect(response).to have_http_status(:success)
    end
  end
end
