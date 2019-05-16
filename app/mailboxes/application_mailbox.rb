# frozen_string_literal: true

class ApplicationMailbox < ActionMailbox::Base
  routing /@replies/i => :replies
end
