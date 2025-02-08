# == Schema Information
#
# Table name: students
#
#  id          :bigint           not null, primary key
#  name        :string
#  roll_number :string
#  course_id   :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    roll_number { rand(5000...1000000) }
    association :course
  end
end
