require 'rails_helper'

describe 'the edit a question path' do
  context 'via the html format' do
    it 'edits a question' do
      user = create(:logged_in_user_with_questions)
      visit edit_question_path(user.questions.first)
      fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
      fill_in "question_options_attributes_1_query", with: attributes_for(:option)[:query]
      click_on "Update Question"
      expect(page).to have_content 'successfully'
    end

    it 'fails to edit a question if an option is omitted' do
      user = create(:logged_in_user_with_questions)
      visit edit_question_path(user.questions.first)
      fill_in "question_options_attributes_1_query", with: ""
      click_on "Update Question"
      expect(page).to have_content 'error'
    end

    it 'fails to edit a question if a user is not logged in' do
      user = create(:user_with_questions)
      visit edit_question_path(user.questions.first)
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end

    it 'fails to edit a question if a user is not the owner of the question or admin' do
      user_0 = create(:user_with_questions)
      user_1 = create(:logged_in_user)
      visit edit_question_path(user_0.questions.first)
      expect(page).to have_content 'permissions'
    end
  end
  #
  # context 'via the js format' do
  #   it 'creates a question with two associated options', js: true do
  #     user = create(:logged_in_user)
  #     visit questions_path
  #     click_on 'New Question'
  #     fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
  #     fill_in "question_options_attributes_1_query", with: attributes_for(:option)[:query]
  #     click_on "Create Question"
  #     expect(page).to have_content 'successfully'
  #   end
  #
  #   it 'fails to create a question if an option is omitted', js: true do
  #     user = create(:logged_in_user)
  #     visit questions_path
  #     click_on 'New Question'
  #     fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
  #     click_on "Create Question"
  #     expect(page).to have_content 'error'
  #   end
  #
  #   it 'fails to create a question if a user is not logged in' do
  #     visit questions_path
  #     expect(page).to_not have_content 'New Question'
  #   end
  # end
end
