require 'rails_helper'

describe 'the user login path' do
  it 'will log in a user' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'successfully'
  end

  it 'will fail to log in a user if information is incorrect' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password + "1"
    click_on 'Log in'
    expect(page).to have_content 'Invalid'
  end
end
