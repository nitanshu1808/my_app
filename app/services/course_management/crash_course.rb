class CrashCourse
	attr_accessor :title, :duration, :subjects, :id

	def initialize(id:, title: ,duration:)
		@id = id
		@title = title
		@duration = duration
		@subjects = []
	end

	def add_subject(subject)
		subjects << subject
	end

	def filter_subjects(name:)
		subjects.select {|subject| subject.name == name}
	end

	def remove_subject(subject)
		subjects.reject!{|obj| obj.id == subject.id }
	end
end
