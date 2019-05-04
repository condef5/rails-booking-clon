require 'rails_helper'

RSpec.describe Api::SessionController, type: :controller do

  describe 'POST login' do
    let(:user_params) do
      { email: 'email@sample.com', password: 'secret123' }
    end
    let!(:user) { User.create(user_params) }

    it 'includes valid keys' do
      post :login, params: user_params
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('auth_token')
    end

    it 'returns unauthorized with unvalid params' do
      user_params[:password] = 'XXX'
      post :login, params: user_params
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
