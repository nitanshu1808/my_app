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
require 'rails_helper'

RSpec.describe Subject, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
