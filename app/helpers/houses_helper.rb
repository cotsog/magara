# frozen_string_literal: true

module HousesHelper
  # Form saves gender information with integer
  # This function helps to return the integer to string.
  #
  #   int_to_gender(@house.preferred_gender)
  #   # => 'Either'
  def int_to_gender(int)
    case int
    when 0
      'Either'
    when 1
      'Female'
    when 2
      'Male'
    end
  end

  # Visualize boolean value with checkmark or cross
  # HTML entity. If the +value+ is true, it returns checkmark.
  # Otherwise, it returns cross sign.
  #
  #   check_it(@house.checkbox.refrigerator)
  #   # => '&checkmark;'
  # rubocop:disable Rails/OutputSafety
  def check_it(value)
    value = case value
            when true
              '&checkmark;'
            else
              '&cross;'
            end

    value.html_safe
  end
  # rubocop:enable Rails/OutputSafety

  def price_range_name(bucket)
    if bucket['from'] && bucket['to']
      "#{number_to_currency bucket['from']} - #{number_to_currency bucket['to']}"
    elsif bucket['from']
      "#{number_to_currency bucket['from']} & Above"
    elsif bucket['to']
      "#{number_to_currency bucket['to']} & Below"
    else
      bucket['key']
    end
  end

  # TODO: DRY it. HousesController has same method.
  def owner?
    true if @house.user == current_user
  end
end
