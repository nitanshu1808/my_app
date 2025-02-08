# == Schema Information
#
# Table name: subjects
#
#  id          :bigint           not null, primary key
#  name        :string
#  course_id   :bigint
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :subject do
    name { Faker::Name.name }
    association :course
    description { "MyText" }
  end
end
