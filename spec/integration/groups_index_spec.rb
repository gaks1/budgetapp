require 'rails_helper'

RSpec.describe 'categories', type: :system do
  let(:icon) do
    Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '85968941.jpg'), 'image/jpeg')
  end

  describe 'home page' do
    before(:each) do
      @user = User.create!(name: 'raihan', email: 'a@gmail.com', password: '123456', confirmed_at: Time.now)
      @group = Group.create!(name: 'group1', icon:, user: @user)
      visit new_user_session_path
      fill_in 'user_email', with: 'a@gmail.com'
      fill_in 'user_password', with: '123456'
      click_on 'Log in'
    end

    it 'shows the right content' do
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('group1')
    end

    it 'creates a new category' do
      click_on 'New category'
      fill_in 'group_name', with: 'category1'
      attach_file 'group_icon', Rails.root.join('spec/fixtures/files/85968941.jpg')
      click_on 'Save'
      expect(page).to have_content('Group was successfully created.')
    end
  end
end
