require 'rails_helper'

RSpec.describe Admin::DashboardController do
  context 'guest' do
    before :each do
      @user_id = nil
      sign_in @user_id
    end
    it 'cannot access admin dashboard' do
      get :index
      expect(response).to have_http_status :missing
    end
  end

  context 'user' do
    before :each do
      @user_id = (create :user).id
      sign_in @user_id
    end
    it 'cannot access admin dashboard' do
      get :index
      expect(response).to have_http_status :missing
    end
  end

  context 'admin' do
    before :each do
      @user_id = (create :admin).id
      sign_in @user_id
    end
    it 'can access admin dashboard' do
      get :index
      expect(response).to have_http_status :success
    end
  end
end