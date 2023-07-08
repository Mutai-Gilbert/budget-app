# Top-level documentation comment for the EntitiesController class
class GroupEntity < ApplicationRecord
  belongs_to :entity
  belongs_to :group
end
