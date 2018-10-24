class AtFutureValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if attribute.present? && value&.present? && value < Time.zone.today
      object.errors[attribute] << (options[:message] || 'must be in the future')
    end
  end
end
