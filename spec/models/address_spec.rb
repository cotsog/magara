# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  subject(:address) { build(:address, house: build(:house)) }

  it 'belongs to a house' do
    expect(subject).to belong_to(:house)
  end

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'is valid without second address field' do
    address.address_2 = nil
    expect(subject).to be_valid
  end

  context 'is not valid without' do
    it 'first address field' do
      address.address_1 = nil
      expect(subject).not_to be_valid
    end

    it 'city' do
      address.city = nil
      expect(subject).not_to be_valid
    end

    it 'state' do
      address.state = nil
      expect(subject).not_to be_valid
    end

    it 'zip_code' do
      address.zip_code = nil
      expect(subject).not_to be_valid
    end
  end

  context 'zip code' do
    it 'is valid with these zip codes' do
      %w[90000 96054 37112 99999 54221-4366 90210-7321].each do |zcode|
        address.zip_code = zcode
        expect(subject).to be_valid
      end
    end

    it 'is not valid with letters' do
      address.zip_code = 'SaMo3'
      expect(subject).not_to be_valid
    end

    it 'is not valid with an improper seperator' do
      ['12342 - 5462', '56331 -5672', '46621- 3677', '23456_1944'].each do |zcode|
        address.zip_code = zcode
        expect(subject).not_to be_valid
      end
    end
  end

  context 'state' do
    it 'is valid with 2 chars' do
      address.state = 'CA'
      expect(subject).to be_valid
    end

    it 'is not valid with more than 2 chars' do
      address.state = 'WSH'
      expect(subject).not_to be_valid
    end

    it 'is capitiliazed after save' do
      state_name = 'ca'

      @address = create(:address, state: state_name, house: build(:house))
      expect(@address.state).to eq(state_name.upcase)
    end

    it 'can not be integer' do
      address.state = 3
      expect(subject).not_to be_valid
    end
  end
end
