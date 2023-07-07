require 'rails_helper'

RSpec.describe 'login', type: :system do
  describe 'login page' do
    before(:each) do
      @user = User.create!(name: 'raihan', email: 'a@gmail.com', password: '123456', confirmed_at: Time.now)
      visit new_user_session_path
    end

    it 'shows the right content' do
      expect(page).to have_content('Log in')
    end

    it 'fills in login details and signs in' do
      fill_in 'user_email', with: 'a@gmail.com'
      fill_in 'user_password', with: '123456'
      click_on 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
  end
end
