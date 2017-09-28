require 'rails_helper'
require 'support/shared_access_examples'

RSpec.describe Admin::EntriesController do
  context 'guest' do
    before :each do
      # do nothing
    end
    include_examples 'controlls access', :entry, :found
    include_examples 'controlls access, redirects', :entry, :found
  end


  context 'user' do
    before :each do
      @user = create :user
      sign_in @user
    end
    include_examples 'controlls access', :entry, :missing
    include_examples 'controlls access, redirects', :entry, :missing
  end

  context 'admin' do
    before :each do
      @user = create :admin
      sign_in @user
    end
    include_examples 'controlls access', :entry, :success
    include_examples 'controlls access, redirects', :entry, :found
  end
end
