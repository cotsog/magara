# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AtFutureValidator do
  subject(:house) do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :date

      validates :date, at_future: true
    end.new
  end

  context 'when date is yesterday' do
    it 'is not valid' do
      house.date = Date.yesterday
      house.validate

      expect(house.errors[:date]).to include 'must be in the future'
    end
  end

  context 'when date is tomorrow' do
    it 'is valid' do
      house.date = Date.tomorrow
      house.validate

      expect(house.errors[:date]).not_to include 'must be in the future'
    end
  end
end
