require 'rails_helper'

module ControllerSignInHelpers
  def sign_in(user_id)
    request.session[:user_id] = user_id
  end
end

module FeatureSignInHelpers
  def sign_in(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in'
  end
end