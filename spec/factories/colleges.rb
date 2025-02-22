# == Schema Information
#
# Table name: colleges
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :college do
    name { Faker::Name.name  }
    description { Faker::Address.full_address }
  end
end
