# frozen_string_literal: true

json.extract! login_signup, :id, :created_at, :updated_at
json.url login_signup_url(login_signup, format: :json)
