require 'rails_helper'

RSpec.describe SearchesController do
  context 'guest' do
    it 'can see Show' do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'can see Create' do
      entry = create :entry
      post :create, params: { entry: { word: entry.word }, format: 'js'}
      expect(response).to have_http_status(:success)
    end
  end

  context 'user' do

    before(:each) do
      @user = create :user
      sign_in @user
    end

    it 'can see Show' do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'can see Create' do
      entry = create :entry
      post :create, params: { entry: { word: entry.word }, format: 'js'}
      expect(response).to have_http_status(:success)
    end
  end

  context 'admin' do
    before :each do
      @admin = create :admin
      sign_in @admin
    end

    it 'can see Show' do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'can see Create' do
      entry = create :entry
      post :create, params: { entry: { word: entry.word }, format: 'js'}
      expect(response).to have_http_status(:success)
    end
  end
end