require 'rails_helper'
require 'devise'

RSpec.describe Entity, type: :feature do
  include Devise::Test::IntegrationHelpers

  describe 'entity' do
    before :each do
      @user = User.create(name: 'Mutai', email: 'mutai@mail.com', password: 111_111)
      sign_in @user

      @group = Group.create(name: 'Travel', icon: 'icon.png', user: @user)
      @entity = Entity.create(name: 'Huwaii', amount: 23, user: @user)

      @group_entity = GroupEntity.create!(entity_id: @entity.id, group_id: @group.id)

      visit group_entities_path(group_id: @group.id)
    end

    it 'render the entity name' do
      expect(page).to have_content('Huwaii')
    end

    it 'render the entity amount' do
      expect(page).to have_content('23')
    end

    it 'should have the create button' do
      expect(page).to have_content('Create New Entity')
    end
  end
end
