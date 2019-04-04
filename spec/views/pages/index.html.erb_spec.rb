# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pages/index.html.erb', type: :view do
  it 'has welcome message' do
    render

    expect(rendered).to match(/Open source platform for students to find their dream house./)
  end
end
