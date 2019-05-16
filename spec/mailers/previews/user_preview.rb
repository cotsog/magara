# frozen_string_literal: true

# Preview all emails at http://127.0.0.1:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  def not_exists
    UserMailer.not_exists(User.first.email)
  end
end
