# frozen_string_literal: true

class House < ApplicationRecord
  has_one :address,  dependent: :destroy
  has_one :checkbox, dependent: :destroy

  has_rich_text :description

  belongs_to :user

  searchkick

  accepts_nested_attributes_for :address,  allow_destroy: true
  accepts_nested_attributes_for :checkbox, allow_destroy: true

  validates :rent, presence: true, numericality: { greater_than: 0 }
  validates :deposit, allow_nil: true, numericality: { greater_than: 0 }
  validates :available_at, presence: true, at_future: true
  validates :built_in, presence: true

  enum preferred_gender: %i[either female male]
  enum status: %i[archived active]
  validates :preferred_gender, presence: true

  def address
    super || build_address
  end

  def checkbox
    super || build_checkbox
  end
end
