require 'rails_helper'

describe 'the user edit path' do
  it 'will edit a user\'s information' do
    user = create(:user)
    login_as user, scope: :user
    visit edit_user_registration_path
    fill_in 'user_username', with: attributes_for(:user)[:username]
    fill_in 'user_email', with: attributes_for(:user)[:email]
    fill_in 'user_current_password', with: user.password
    click_on 'Update'
    expect(page).to have_content 'successfully'
  end

  it 'will fail to sign up a user if information is omitted' do
    user = create(:user)
    login_as user, scope: :user
    visit edit_user_registration_path
    fill_in 'user_username', with: ''
    fill_in 'user_current_password', with: user.password
    click_on 'Update'
    expect(page).to have_content 'error'
  end
end
