# frozen_string_literal: true

json.array! @login_signups, partial: 'login_signups/login_signup', as: :login_signup
