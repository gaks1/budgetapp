require 'rails_helper'

RSpec.describe 'categories', type: :system do
  let(:icon) do
    Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '85968941.jpg'), 'image/jpeg')
  end

  describe 'show page' do
    before(:each) do
      @user = User.create!(name: 'raihan', email: 'a@gmail.com', password: '123456', confirmed_at: Time.now)
      @group = Group.create!(name: 'group1', icon:, user: @user)
      @entity = Entity.create!(name: 'apple', amount: 230, author: @user)
      @group.entities << @entity
      visit new_user_session_path
      fill_in 'user_email', with: 'a@gmail.com'
      fill_in 'user_password', with: '123456'
      click_on 'Log in'
      click_on 'group1'
    end

    it 'shows the right content' do
      expect(page).to have_content('group1')
      expect(page).to have_content('apple')
      expect(page).to have_content('230')
    end

    it 'creates a new entity' do
      click_on 'New transaction'
      fill_in 'entity_name', with: 'entity1'
      fill_in 'entity_amount', with: '100'
      select 'group1', from: 'entity_group_ids'
      click_on 'Save'
      expect(page).to have_content('Entity was successfully created.')
    end
  end
end
