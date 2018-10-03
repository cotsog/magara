require 'rails_helper'

RSpec.describe Address do
  let(:address) { create(:address, house: build(:house)) }

  it 'should be valid' do
    expect(address).to be_valid
  end

  it 'should be valid without second address field' do
    address.address_2 = nil
    expect(address).to be_valid
  end

  context 'should not be valid without' do
    it 'first address field' do
      address.address_1 = nil
      expect(address).to_not be_valid
    end

    it 'city' do
      address.city = nil
      expect(address).to_not be_valid
    end

    it 'state' do
      address.state = nil
      expect(address).to_not be_valid
    end

    it 'zip_code' do
      address.zip_code = nil
      expect(address).to_not be_valid
    end
  end

  context 'zip code' do
    it 'should be valid with these zip codes' do
      %w[90000 96054 37112 99999 54221-4366 90210-7321].each do |zcode|
        address.zip_code = zcode
        expect(address).to be_valid
      end
    end

    it 'should not be valid with letters' do
      address.zip_code = 'SaMo3'
      expect(address).to_not be_valid
    end

    it 'should not be valid with an improper seperator' do
      ['12342 - 5462', '56331 -5672', '46621- 3677', '23456_1944'].each do |zcode|
        address.zip_code = zcode
        expect(address).to_not be_valid
      end
    end
  end

  context 'state' do
    it 'should be valid which it has only 2 chars' do
      address.state = 'CA'
      expect(address).to be_valid
    end

    it 'should not be valid which it does not have only 2 chars' do
      address.state = 'WSH'
      expect(address).to_not be_valid
    end

    it 'should be capitiliazed after save' do
      state_name = 'ca'

      @address = create(:address, state: state_name, house: build(:house))
      expect(@address.state).to eq(state_name.upcase)
    end

    it 'can not be integer' do
      address.state = 3
      expect(address).to_not be_valid
    end
  end
end
