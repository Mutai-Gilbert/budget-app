# frozen_string_literal: true

# Top-level documentation comment for the EntitiesController class
class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
  end
end
