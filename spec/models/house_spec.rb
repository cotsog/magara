require 'rails_helper'

RSpec.describe House do
  subject(:house) { create(:house, :either) }

  it 'is valid' do
    is_expected.to be_valid
  end

  context 'rent' do
    it 'is not valid without' do
      house.rent = nil
      is_expected.not_to be_valid
    end

    it 'can not be negative' do
      house.rent = -1
      is_expected.not_to be_valid
    end

    it 'can not be string'  do
      house.rent = 'three hundred'
      is_expected.to_not be_valid
    end

    it 'can not be zero' do
      house.rent = 0
      is_expected.not_to be_valid
    end
  end

  context 'deposit' do
    it 'is valid with' do
      house.deposit = 999
      is_expected.to be_valid
    end

    it 'is valid without' do
      house.deposit = nil
      is_expected.to be_valid
    end

    it 'can not be negative' do
      house.deposit = -1
      is_expected.not_to be_valid
    end

    it 'can not be a string' do
      house.deposit = 'lots'
      is_expected.not_to be_valid
    end

    it 'can not be zero' do
      house.deposit = 0
      is_expected.not_to be_valid
    end
  end

  context 'preferred gender' do
    it 'is not valid without' do
      house.preferred_gender = nil
      is_expected.not_to be_valid
    end

    it 'is not an included preferred gender' do
      house.preferred_gender = 3
      is_expected.not_to be_valid
    end

    it 'is an included preferred gender' do
      house.preferred_gender = 2
      is_expected.to be_valid
    end
    # XXX:
    #   ActiveRecord or something returns string to zero.
    #
    # it "can not be integer which is string"
    # it "can not be text"
  end

  context 'available at' do
    it 'is not valid if time is past' do
      house.available_at = 1.week.ago
      is_expected.not_to be_valid
    end

    it 'is valid if time is today' do
      house.available_at = Time.zone.today
      is_expected.to be_valid
    end

    it 'is valid if time is future' do
      house.available_at = 1.week.after
      is_expected.to be_valid
    end

    it 'is not valid without' do
      house.available_at = nil
      is_expected.not_to be_valid
    end
  end
end
