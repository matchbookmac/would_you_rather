require 'rails_helper'

describe 'the user edit path' do
  it 'will edit a user\'s information' do
    user = create(:logged_in_user)
    visit edit_user_registration_path
    fill_in 'user_username', with: attributes_for(:user)[:username]
    fill_in 'user_email', with: attributes_for(:user)[:email]
    fill_in 'user_current_password', with: user.password
    click_on 'Update'
    expect(page).to have_content 'successfully'
  end

  it 'will fail to edit a user if information is omitted' do
    user = create(:logged_in_user)
    visit edit_user_registration_path
    fill_in 'user_username', with: ''
    fill_in 'user_current_password', with: user.password
    click_on 'Update'
    expect(page).to have_content 'error'
  end

  it 'will fail to edit a user if user is not logged in' do
    visit edit_user_registration_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'will send a user\'s reset password to them' do
    user = create(:user)
    visit new_user_password_path
    fill_in 'Email', with: user.email
    click_on 'Send me reset password instructions'
    expect(ActionMailer::Base.deliveries.last.to).to eq [user.email]
  end
end
