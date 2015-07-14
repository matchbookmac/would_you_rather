require 'rails_helper'

describe 'the cast a vote path' do
  context 'via the js format', js: true do
    it 'creates a vote for an option' do
      question = create(:question)
      user = create(:logged_in_user)
      visit questions_path
      click_on "option_#{question.options.first.id}_vote_button"
      expect(page).to have_content 'Your vote has been cast'
    end

    it 'fails to vote on an option if a user has alread voted on it' do
      question = create(:question)
      user = question.options.first.votes.first.user
      login_as user, scope: :user
      visit questions_path
      expect(page).to_not have_css "option_#{question.options.first.id}_vote_button"
    end

    it 'fails to vote on an option if user is not logged in' do
      question = create(:question)
      visit questions_path
      expect(page).to_not have_css "option_#{question.options.first.id}_vote_form"
    end
  end
end
