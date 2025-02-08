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
class Subject < ApplicationRecord
	include UtilityHelper

	belongs_to :course
end
