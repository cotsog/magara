# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def not_exists(email)
    mail to: email
  end
end
