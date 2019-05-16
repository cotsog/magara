# frozen_string_literal: true

class User < ApplicationRecord
  before_create :generate_uuid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :houses, dependent: :destroy
  validates_associated :houses

  validates :uuid, presence: true, on: :update

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
