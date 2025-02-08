class CrashCourse
	attr_accessor :title, :subjects, :id

	def initialize(id:, title:)
		@id = id
		@title = title
		@subjects = []
	end

	def add_subjects(subject)
		subjects << subject
	end

	def filter_subjects(name:)
		subjects.select {|subject| subject.name == name}
	end

	def remove_subject(id:)
		subjects.reject!{|obj| obj.id == id } || []
	end
end
