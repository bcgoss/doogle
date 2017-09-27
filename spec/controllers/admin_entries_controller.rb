require 'rails_helper'
require 'support/shared_access_examples'

RSpec.describe Admin::EntriesController do
  context 'guest' do
    before :each do
      @user_id = nil
      sign_in @user_id
    end
    include_examples 'controlls access', :entry, :missing
  end


  context 'user' do

  end

  context 'admin' do
    before :each do
      @user_id = (create :admin).id
      sign_in @user_id
    end
    include_examples 'controlls access', :entry, :success
  end
end
