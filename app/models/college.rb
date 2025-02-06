class College < ApplicationRecord
  # has_many :courses
  # has_many :students

  validates :name, :description, presence: true
  validate :name_length

  private

  def name_length
    errors.add(:name, :invalid_size) unless self.name&.length >= 3
  end
end
