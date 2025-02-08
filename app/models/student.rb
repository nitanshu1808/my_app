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
class Student < ApplicationRecord
	include UtilityHelper

  belongs_to :course
end
