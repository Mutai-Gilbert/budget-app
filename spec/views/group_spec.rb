require 'rails_helper'
require 'devise'

RSpec.describe Group, type: :feature do
  include Devise::Test::IntegrationHelpers

  describe 'group' do
    before :each do
      @user = User.create(name: 'Mutai', email: 'mutai@mail.com', password: 111_111)
      sign_in @user
      @group = Group.create(name: 'Travel', icon: 'icon.png', user: @user)
      visit groups_path
    end

    it 'renders the group name' do
      expect(page).to have_content('Travel')
    end

    it 'should have the date' do
      expect(page).to have_content(DateTime.parse(@group.created_at.to_s).strftime('%d-%m-%Y'))
    end
  end
end
