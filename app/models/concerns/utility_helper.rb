module UtilityHelper
	extend ActiveSupport::Concern

	included do
		validates :name, presence: true
		validate :name_length
	end

	private

  def name_length
    errors.add(:name, :invalid_size) unless self.name&.length >= 3
  end
end