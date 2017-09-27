require 'rails_helper'
require 'support/shared_access_examples'

RSpec.describe Admin::DefinitionsController do
  context 'guest' do
    before :each do
      @user_id = nil
      sign_in @user_id
    end
    include_examples 'controlls access', :definition, :missing
  end

  context 'user' do
    before :each do
      @user_id = (create :user).id
      sign_in @user_id
    end
    include_examples 'controlls access', :definition, :missing
  end

  context 'admin' do
    before :each do
      @user_id = (create :admin).id
      sign_in @user_id
    end
    include_examples 'controlls access', :definition, :success
  end
end