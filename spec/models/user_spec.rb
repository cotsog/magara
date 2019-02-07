# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it 'has many houses' do
    t = described_class.reflect_on_association(:houses)
    expect(t.macro).to eq(:has_many)
  end

  it { is_expected.to have_many(:houses).dependent(:destroy) }
end
