class Address < ApplicationRecord
  before_save :upcase_state
  after_validation :geocode

  geocoded_by :full_address

  belongs_to :house

  validates :address_1, presence: true
  validates :city,      presence: true
  # HACK: Only save upcase state abbr name
  validates :state,     presence: true, length: { is: 2 }
  # HACK: The RegEx validation is needed to be refactored
  validates :zip_code,  presence: true, format: { with: /\A[0-9]{5}(?:-[0-9]{4})?\z/ }

  def full_address
    [address_1, address_2, city, state, zip_code].compact.join(', ')
  end

  private

  def upcase_state
    state.upcase!
  end
end
