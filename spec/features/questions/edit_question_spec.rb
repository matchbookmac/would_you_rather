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

    it 'edits a question belonging to another user if the current user is admin' do
      user = create(:user_with_questions)
      admin = create(:logged_in_admin)
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

  context 'via the js format', js: true do
    it 'edits a question' do
      user = create(:logged_in_user_with_questions)
      visit questions_path
      first(:link, "Edit").click
      fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
      fill_in "question_options_attributes_1_query", with: attributes_for(:option)[:query]
      click_on "Update Question"
      expect(page).to have_content 'successfully'
    end

    it 'edits a question belonging to another user if the current user is admin' do
      user = create(:user_with_questions)
      admin = create(:logged_in_admin)
      visit questions_path
      first(:link, "Edit").click
      fill_in "question_options_attributes_0_query", with: attributes_for(:option)[:query]
      fill_in "question_options_attributes_1_query", with: attributes_for(:option)[:query]
      click_on "Update Question"
      expect(page).to have_content 'successfully'
    end

    it 'fails to edit a question if an option is omitted' do
      user = create(:logged_in_user_with_questions)
      visit questions_path
      first(:link, "Edit").click
      fill_in "question_options_attributes_1_query", with: ""
      click_on "Update Question"
      expect(page).to have_content 'error'
    end

    it 'fails to edit a question if a user is not logged in' do
      user = create(:user_with_questions)
      visit questions_path
      expect(page).to_not have_content 'Edit'
    end

    it 'fails to edit a question if a user is not the owner of the question or admin' do
      user_0 = create(:user_with_questions)
      user_1 = create(:logged_in_user)
      visit questions_path
      expect(page).to_not have_content 'Edit'
    end
  end
end
