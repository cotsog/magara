# frozen_string_literal: true

class AtFutureValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    object.errors[attribute] << (options[:message] || 'must be in the future') if attribute.present? && (value&.present? < Time.zone.today)
  end
end
