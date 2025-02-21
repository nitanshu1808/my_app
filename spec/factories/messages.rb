FactoryBot.define do
  factory :message do
    association :sender
    association :recipient
    association :conversation
    content { Faker::Name.name }
  end
end
