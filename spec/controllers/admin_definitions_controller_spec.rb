require 'rails_helper'
require 'support/shared_access_examples'

RSpec.describe Admin::DefinitionsController do
  context 'guest' do
    before :each do
      # do nothing
    end
    include_examples 'controlls access', :definition, :found
    include_examples 'controlls access, redirects', :definition, :found
  end

  context 'user' do
    before :each do
      @user = create :user
      sign_in @user
    end
    include_examples 'controlls access', :definition, :missing
    include_examples 'controlls access, redirects', :definition, :missing
  end

  context 'admin' do
    before :each do
      @user = create :admin
      sign_in @user
    end
    include_examples 'controlls access', :definition, :success
    include_examples 'controlls access, redirects', :definition, :found
  end
end