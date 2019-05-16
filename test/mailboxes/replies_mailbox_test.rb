# frozen_string_literal: true

require 'test_helper'

class RepliesMailboxTest < ActionMailbox::TestCase
  # XXX: Watch out. We are using our domain, and it needs to be magara.local
  # or something else because we need to make sure that everybody can run on
  # their domain
  test 'recive email' do
    house = create(:house)
    user  = create(:user)

    replied_email = receive_inbound_email_from_mail \
      to: "#{house.user.uuid}@replies.magara.ist",
      from: user.email,
      subject: 'Hey, I am interested in!',
      body: <<~BODY
        Hey this is #{user.email},

        I want to talk to you!

        Thank you
      BODY

    assert_equal 'Hey, I am interested in!', replied_email.mail.subject
    assert_equal "#{user.uuid}@replies.magara.ist", replied_email.mail.from.first
  end
end
