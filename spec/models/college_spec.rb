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
require 'rails_helper'

RSpec.describe College, type: :model do
  subject { FactoryBot.build(:college) }

  it { is_expected.to be_valid }
end
