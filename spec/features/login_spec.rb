require 'rails_helper'

RSpec.describe 'Log in' do
  context 'no user' do
    it 'creates a new user' do
      visit signup_path
      fill_in 'Email', with: 'subject@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'

      expect(page).to have_content 'Welcome!'
    end

    it 'fails to sign in' do
      visit login_path
      fill_in 'Email', with: 'anything'
      fill_in 'Password', with: 'anything'
      click_button 'Log in'

      expect(page).to have_content 'Invalid email or password'
    end
  end

  context 'valid user' do
    it 'logs in' do
      subject = create :user, email: 'subject@example.com'
      visit login_path
      fill_in 'Email', with: subject.email
      fill_in 'Password', with: subject.password
      click_button 'Log in'

      expect(page).to have_content 'Signed in with subject@example.com'
    end

    it 'fails with invalid credentials' do
      subject = create :user, email: 'subject@example.com', password: 'validPassword', password_confirmation: 'validPassword'
      visit login_path
      fill_in 'Email', with: 'invalid@example.com'
      fill_in 'Password', with: subject.password
      click_button 'Log in'

      expect(page).to have_content 'Invalid email or password'

      fill_in 'Email', with: subject.email
      fill_in 'Password', with: 'invalidPassword'
      click_button 'Log in'

      expect(page).to have_content 'Invalid email or password'
    end
  end
end

RSpec.describe 'Log out' do
  it 'works' do
    subject = create :user
    sign_in subject

    visit logout_path

    expect(page).to have_content 'Logged out'
  end
end