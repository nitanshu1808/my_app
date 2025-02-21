class CourseSubject
	attr_accessor :id, :name

	def initialize(id:, name:)
		@id = id
		@name = name
	end

	def self.filter(subjects: [], name:)
		subjects.select { |subject| subject.name == name}
	end
end
