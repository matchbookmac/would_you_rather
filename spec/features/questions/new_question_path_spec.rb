require 'rails_helper'

describe 'the ask a question path' do
  it 'creates a question with two associated options' do
    user = create(:user)
    login_as user, scope: :user
    visit new_question_path
    fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
    fill_in "question_options_attributes_1_query", with: attributes_for(:option)[:query]
    click_on "Create Question"
    expect(page).to have_content 'successfully'
  end

  it 'fails to create a question if an option is omitted' do
    user = create(:user)
    login_as user, scope: :user
    visit new_question_path
    fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
    click_on "Create Question"
    expect(page).to have_content 'error'
  end
end
