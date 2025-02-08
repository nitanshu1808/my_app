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
class Course < ApplicationRecord
	belongs_to :college
	has_many :students
	has_many :subjects
end
