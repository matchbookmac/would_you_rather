require 'rails_helper'

describe 'the user sign up path' do
  it 'will sign up a user' do
    password = attributes_for(:user)[:password]
    visit new_user_registration_path
    fill_in 'user_username', with: attributes_for(:user)[:username]
    fill_in 'user_email', with: attributes_for(:user)[:email]
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_on 'Sign up'
    expect(page).to have_content 'successfully'
  end

  it 'will fail to sign up a user if information is omitted' do
    visit new_user_registration_path
    fill_in 'user_username', with: attributes_for(:user)[:username]
    fill_in 'user_email', with: attributes_for(:user)[:email]
    click_on 'Sign up'
    expect(page).to have_content 'error'
  end
end
