# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@magara.ist'
  layout 'mailer'
end
