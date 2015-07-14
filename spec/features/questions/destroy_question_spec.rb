require 'rails_helper'

describe 'the destroy a question path' do
  context 'via the html format' do
    it 'destroys a question' do
      user = create(:logged_in_user_with_questions)
      visit question_path(user.questions.first)
      click_on "Destroy"
      expect(page).to have_content 'successfully'
    end

    it 'destroys a question belonging to another user if the current user is admin' do
      user = create(:user_with_questions)
      admin = create(:logged_in_admin)
      visit question_path(user.questions.first)
      click_on "Destroy"
      expect(page).to have_content 'successfully'
    end

    it 'fails to destroy a question if a user is not logged in' do
      user = create(:user_with_questions)
      visit question_path(user.questions.first)
      expect(page).to_not have_content 'Destroy'
    end

    it 'fails to destroy a question if a user is not the owner of the question or admin' do
      user_0 = create(:user_with_questions)
      user_1 = create(:logged_in_user)
      visit question_path(user_0.questions.first)
      expect(page).to_not have_content 'Destroy'
    end
  end

  context 'via the js format', js: true do
    it 'destroys a question' do
      user = create(:logged_in_user_with_questions)
      visit questions_path
      first(:link, "Destroy").click
      expect(page).to have_content 'successfully'
    end

    it 'destroys a question belonging to another user if the current user is admin' do
      user = create(:user_with_questions)
      admin = create(:logged_in_admin)
      visit questions_path
      first(:link, "Destroy").click
      expect(page).to have_content 'successfully'
    end

    it 'fails to destroy a question if a user is not logged in' do
      user = create(:user_with_questions)
      visit questions_path
      expect(page).to_not have_content 'Destroy'
    end

    it 'fails to destroy a question if a user is not the owner of the question or admin' do
      user_0 = create(:user_with_questions)
      user_1 = create(:logged_in_user)
      visit questions_path
      expect(page).to_not have_content 'Destroy'
    end
  end
end
