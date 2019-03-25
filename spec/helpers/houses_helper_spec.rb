# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HousesHelper, type: :helper do
  describe '#int_to_gender' do
    it 'returns integer to string of gender name' do
      expect(helper.int_to_gender(0)).to eq('Either')
      expect(helper.int_to_gender(1)).to eq('Female')
      expect(helper.int_to_gender(2)).to eq('Male')
    end
  end

  describe '#check_it' do
    it 'returns boolean to HTML safe checkmark or cross' do
      expect(helper.check_it(true)).to eq('&checkmark;')
      expect(helper.check_it(false)).to eq('&cross;')
    end
  end

  describe '#price_range_name' do
    it 'returns a bucket to more meaningful name' do
      bucket = { 'key' => '500.0-1000.0',
                 'from' => 500.0, 'to' => 1000.0,
                 'doc_count' => 1 }

      expect(helper.price_range_name(bucket)).to(
        eq("#{number_to_currency 500.0} - #{number_to_currency 1_000.0}")
      )

      bucket = { 'key' => '*-500.0',
                 'to' => 500.0,
                 'doc_count' => 1 }

      expect(helper.price_range_name(bucket)).to(
        eq("#{number_to_currency 500.0} & Below")
      )

      bucket = { 'key' => '1000.0-*',
                 'from' => 1000.0,
                 'doc_count' => 1 }

      expect(helper.price_range_name(bucket)).to(
        eq("#{number_to_currency 1000.0} & Above")
      )
    end
  end
end
