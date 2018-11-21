class House < ApplicationRecord
  require_dependency 'validators/at_future_validator.rb'

  has_one :address,  dependent: :destroy
  has_one :checkbox, dependent: :destroy

  belongs_to :user

  accepts_nested_attributes_for :address,  allow_destroy: true
  accepts_nested_attributes_for :checkbox, allow_destroy: true

  validates :rent,             presence: true,
                               numericality: { greater_than: 0 }
  validates :deposit,          allow_nil: true,
                               numericality: { greater_than: 0 }
  validates :preferred_gender, presence: true, inclusion: { in: 0..2 }
  validates :available_at,     presence: true, at_future: true

  def address
    super || build_address
  end

  def checkbox
    super || build_checkbox
  end

  def self.search(term)
    if term
      House.joins(:address)
           .where("description LIKE :term OR cast(available_at as text)\
           LIKE :term OR cast(lease_length as text) LIKE :term OR\
           cast(built_in as text) LIKE :term OR city LIKE :term OR address_1\
           LIKE :term OR address_2 LIKE :term OR cast(state as text)\
           LIKE :term OR cast(zip_code as text) LIKE :term", term: term)
    else
      all
    end
  end
end
