require 'rails_helper'

RSpec.describe College, type: :model do
  subject { FactoryBot.build(:college) }

  it { is_expected.to be_valid }
end
