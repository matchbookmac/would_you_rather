require 'rails_helper'

describe 'the ask a question path' do
  context 'via the html format' do
    it 'creates a question with two associated options' do
      user = create(:logged_in_user)
      visit new_question_path
      fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
      fill_in "question_options_attributes_1_query", with: attributes_for(:option)[:query]
      click_on "Create Question"
      expect(page).to have_content 'successfully'
    end

    it 'fails to create a question if an option is omitted' do
      user = create(:logged_in_user)
      visit new_question_path
      fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
      click_on "Create Question"
      expect(page).to have_content 'error'
    end

    it 'fails to create a question if a user is not logged in' do
      visit new_question_path
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end

  context 'via the js format' do
    it 'creates a question with two associated options' do
      user = create(:logged_in_user)
      visit questions_path
      fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
      fill_in "question_options_attributes_1_query", with: attributes_for(:option)[:query]
      click_on "Create Question"
      expect(page).to have_content 'successfully'
    end

    it 'fails to create a question if an option is omitted' do
      user = create(:logged_in_user)
      visit questions_path
      fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
      click_on "Create Question"
      expect(page).to have_content 'error'
    end

    it 'fails to create a question if a user is not logged in' do
      visit questions_path
      expect(page).to_not have_content 'New Question'
    end
  end
end
