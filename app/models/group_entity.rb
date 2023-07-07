# frozen_string_literal: true

class GroupEntity < ApplicationRecord
  belongs_to :entity
  belongs_to :group
end
