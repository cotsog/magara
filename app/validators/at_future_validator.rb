# frozen_string_literal: true

##
# This validator validates future date. If the date is in future, does nothing.
# However, if not, adds a record error as must be in the future. This function
# does NOT work the other way around. Also, worth to mention, this function
# only works with date; not time or date+time.
#
# == Example
#
#   class Person < ApplicationRecord
#     attr_accessor :birth_day
#
#     validates :birth_day, at_future: true
#   end

class AtFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value&.present? && value < Date.current
      record.errors.add attribute, 'must be in the future'
    end
  end
end
