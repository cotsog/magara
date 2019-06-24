# frozen_string_literal: true

require 'rails_helper'

RSpec.describe House do
  subject(:house) { build(:house, :either) }

  it 'belongs to a user' do
    assc = described_class.reflect_on_association(:user)
    expect(assc.macro).to eq :belongs_to
  end

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'has an associated address' do
    expect(subject).to have_one(:address).dependent(:destroy)
  end

  it 'has an associated checkbox' do
    expect(subject).to have_one(:checkbox).dependent(:destroy)
  end

  context 'status' do
    it 'has an archived status by default' do
      expect(subject.status).to eq 'archived'
    end

    it 'archived has a 0 value' do
      house.status = 0
      expect(subject.status).to eq 'archived'
    end

    it 'active has a 1 value' do
      house.status = 1
      expect(subject.status).to eq 'active'
    end
  end

  context 'rent' do
    it 'is not valid without' do
      house.rent = nil
      expect(subject).not_to be_valid
    end

    it 'can not be negative' do
      house.rent = -1
      expect(subject).not_to be_valid
    end

    it 'can not be string' do
      house.rent = 'three hundred'
      expect(subject).not_to be_valid
    end

    it 'can not be zero' do
      house.rent = 0
      expect(subject).not_to be_valid
    end
  end

  context 'deposit' do
    it 'is valid with' do
      house.deposit = 999
      expect(subject).to be_valid
    end

    it 'is valid without' do
      house.deposit = nil
      expect(subject).to be_valid
    end

    it 'can not be negative' do
      house.deposit = -1
      expect(subject).not_to be_valid
    end

    it 'can not be a string' do
      house.deposit = 'lots'
      expect(subject).not_to be_valid
    end

    it 'can not be zero' do
      house.deposit = 0
      expect(subject).not_to be_valid
    end
  end

  context 'preferred gender' do
    it 'is not valid with nil' do
      house.preferred_gender = nil
      expect(subject).not_to be_valid
    end

    it 'is valid with the name of gender' do
      house.preferred_gender = 'male'
      expect(subject).to be_valid
    end
  end

  context 'available at' do
    it 'is not valid if time is past' do
      house.available_at = 1.week.ago
      expect(subject).not_to be_valid
    end

    it 'is valid if time is today' do
      house.available_at = Time.zone.today
      expect(subject).to be_valid
    end

    it 'is valid if time is future' do
      house.available_at = 1.week.after
      expect(subject).to be_valid
    end

    it 'is not valid without' do
      house.available_at = nil
      expect(subject).not_to be_valid
    end
  end

  context 'built in' do
    it 'is valid if time is past' do
      house.built_in = 1.week.ago
      expect(subject).to be_valid
    end

    xit 'is not valid if tim is future' do
      house.built_in = 1.week.after
      expect(subject).not_to be_valid
    end

    it 'is not valid without' do
      house.built_in = nil
      expect(subject).not_to be_valid
    end
  end
end
