require 'rails_helper'

RSpec.describe Checkbox do
  subject(:checkbox) { create(:checkbox, house: build(:house)) }

  it 'is valid' do
    is_expected.to be_valid
  end

  # All of them true because of the beautiy of Active Record <3
  # AR returns to true them except the +nil+.
  ['true', 1, nil].each do |lol|
    it "is not valid if it has #{lol}" do
      checkbox.air_conditioning = lol
      is_expected.to be_valid
    end
  end
end
