require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  def authorization_header
    user = User.create(
      email: "space@gmail.com",
      name:'space',
      password:'secret123',
      role:'admin'
    )
    token = JSONWebToken.encode(user_id: user.id)
    { 'Authorization': "Bearer #{token}" }
  end

  before do
    request.headers.merge!(authorization_header)
    @user = User.create(
      name: 'lian',
      email: 'liamrn94@gmail.com',
      password: 'asdasdfjalksj',
      role: 'user'
    )
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response.status).to eq 200
    end

    it 'render json with all users' do
      get :index
      users = JSON.parse(response.body)
      expect(users.size).to eq 2
    end
  end

  describe 'GET show' do
    it 'return http status ok' do 
      get :show, params: {id: @user}
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct user' do
      get :show, params: {id: @user}
      expected_user = JSON.parse(response.body)
      expect(expected_user["id"]).to eq(@user.id)
    end

    it 'returns http status not found' do
      get :show, params: {id: 'xxx'}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST create' do
    it 'return http status created' do
      post :create, params: {
        name: 'lian',
        email: 'liamrn96@gmail.com',
        password: 'asdasdfjalksj',
        role: 'user'
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created) 
    end

    it 'returns the user created' do
      post :create, params: {
        name: 'lian',
        email: 'liamrn96@gmail.com',
        password: 'asdasdfjalksj',
        role: 'user'
      }
      expected_user = JSON.parse(response.body)
      
      expect(expected_user).to have_key("id")
      expect(expected_user["name"]).to eq("lian")
    end

    it "returns error's fields" do
      post :create, params: {password: 'alk'}
      expected_errors = JSON.parse(response.body)
      expect(expected_errors).to have_key("errors")
    end
  end

  describe 'PATCH update' do
    it 'returns http status created' do
      patch :update, params: {
        id: @user.id,
        email: 'liamrn99@gmail.com'
      }
      expect(response).to have_http_status(:ok)
    end
    
    it 'returns the updated user' do
      patch :update, params: {
        id: @user.id,
        email: 'liamrn99@gmail.com'
      }
      expected_user = JSON.parse(response.body)
      expect(expected_user["email"]).to eq("liamrn99@gmail.com")
    end
  end

  describe 'DELETE destroy' do
    it 'returns http status no content' do
      delete :destroy, params: {
        id: @user
      }
      expect(response).to have_http_status(:no_content)
    end

    it 'decrement by 1 the total of users' do
      expect do
        delete :destroy, params: {id: @user}
      end.to change {User.count}.by(-1)
    end
  end
end