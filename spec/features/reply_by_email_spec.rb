# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ReplyByEmail', type: :feature do
  context 'with signed in user' do
    let(:landlord) { create :user }
    let(:house)    { create :house, user: landlord }

    let(:student) { create :user }

    before do
      sign_in student
    end

    it 'User looks for the reply email' do
      visit "/houses/#{house.id}"
      expect(page).to have_text("#{landlord.uuid}@replies.magara.ist")
    end
  end
end
