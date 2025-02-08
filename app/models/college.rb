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

class College < ApplicationRecord
  include UtilityHelper

  has_many :courses

  validates :description, presence: true

  scope :filter_by_name, -> (name) {where("name ILIKE ?", "%#{name}%")}
  scope :filter_by_description, -> (description) { where("description ILIKE ?", "%#{description}%") if description.present?}
  scope :filter_by_created_at_range, -> (start_date, end_date) { where(created_at: start_date.to_date..end_date.to_date)}
  scope :filter_without_courses, -> { left_joins(:courses).where(courses: {id: nil} )}

  def self.filter(filter={})
    res = self.all
    return res if filter.empty?
    
    created_at_filter = filter[:created_at]

    res.filter_by_name(filter[:name]) if filter[:name].present?
    res.filter_by_description(filter[:description]) if filter[:description].present?
    res.filter_by_created_at_range(created_at_filter[:start_date], created_at_filter[:end_date]) if created_at_filter[:start_date].present? && created_at_filter[:end_date].present?
    res.joins(:students) if filter[:with_students].present?
    res.left_joins(:students).where(students: {id: nil}) if filter[:without_students]
    res
  end


  def self.search(search={})
    return all if search.empty?

    self.where("name ILIKE ? OR description ILIKE ?", "%#{search[:string]}%", "%#{search[:string]}%")
  end
end
