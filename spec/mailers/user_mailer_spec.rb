# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'not_exists' do
    let(:mail) { UserMailer.not_exists('to@example.org') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Not exists')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['no-reply@magara.ist'])
    end
  end
end
