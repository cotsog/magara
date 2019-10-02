require "rails_helper"

RSpec.describe AtFutureValidator do
  subject do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :date

      validates :date, at_future: true
    end.new
  end

  context "when date is yesterday" do
    it "is not valid" do
      subject.date = Date.yesterday
      subject.validate

      expect(subject.errors[:date]).to include 'must be in the future'
    end
  end

  context "when date is tomorrow" do
    it "is valid" do
      subject.date = Date.tomorrow
      subject.validate

      expect(subject.errors[:date]).to_not include 'must be in the future'
    end
  end
end
