# frozen_string_literal: true

module HousesHelper
  # Visualize boolean value with checkmark or cross
  # HTML entity. If the +value+ is true, it returns checkmark.
  # Otherwise, it returns cross sign.
  #
  #   check_it(@house.checkbox.refrigerator)
  #   # => '&checkmark;'
  def check_it(value)
    value ? '&checkmark;'.html_safe : '&cross;'.html_safe
  end

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

  def owner?
    true if @house&.user == current_user
  end
end
