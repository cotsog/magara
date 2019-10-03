# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    rent             { Random.rand 400..1200 }
    deposit          { Random.rand 400..1200 }
    description      { Faker::Lorem.sentence }
    available_at     { 3.weeks.after }
    preferred_gender { 'female' }
    status           { 'archived' }
    built_in         { 1.year.from_now }

    association :user, factory: :user

    trait :either do
      preferred_gender { 0 }
    end

    trait :female do
      preferred_gender { 1 }
    end

    trait :male do
      preferred_gender { 2 }
    end

    trait :archieved do
      status { 0 }
    end

    trait :active do
      status { 1 }
    end
  end
end
