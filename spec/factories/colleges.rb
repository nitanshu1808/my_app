FactoryBot.define do
  factory :college do
    name { Faker::Name.name  }
    description { Faker::Address.full_address }
  end
end
