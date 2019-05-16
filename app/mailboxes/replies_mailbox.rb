# frozen_string_literal: true

class RepliesMailbox < ApplicationMailbox
  before_processing :ensure_sender_is_a_user
  before_processing :ensure_reciver_is_a_user
  around_processing :swap_email_address

  def process; end

  private

  def ensure_sender_is_a_user
    bounce_with UserMailer.not_exists(sender_email) unless User.exists?(email: sender_email)
  end

  def ensure_reciver_is_a_user
    bounced! unless User.exists?(uuid: mail_uuid)
  end

  def swap_email_address
    a = sender_email
    mail.from -= [sender_email]
    mail.from += ["#{User.find_by(email: a).uuid}@replies.magara.ist"]
  end

  # finds an UUID pattern which resides before the @ sign
  def mail_uuid
    mail.to.first.match(/[^@]*/)
  end

  def sender_email
    mail.from.first
  end

  def reciver
    @reciver ||= User.find_by(uuid: mail_uuid)
  end

  def sender
    @sender ||= User.find_by(email: sender_email)
  end
end
