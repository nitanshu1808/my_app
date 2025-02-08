# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  title      :string
#  duration   :integer
#  college_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :course do
    title { Faker::Name.name }
    duration { rand(1..10) }
    association :college
  end
end
