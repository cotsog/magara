# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAGARA_DOMAIN']
  layout 'mailer'
end
