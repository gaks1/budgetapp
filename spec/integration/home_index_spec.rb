require 'rails_helper'

RSpec.describe 'Home', type: :system do
  describe 'index page' do
    it 'shows the right content' do
      visit root_path
      expect(page).to have_content('Money Mind')
      expect(page).to have_content('Track your expenses')
    end

    it 'clicks sign up button' do
      visit root_path
      click_on 'Sign Up'
      expect(page).to have_content('Sign up')
    end

    it 'clicks sign in button' do
      visit root_path
      click_on 'Sign In'
      expect(page).to have_content('Log in')
    end
  end
end
