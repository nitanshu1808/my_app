require 'rails_helper'

RSpec.describe CrashCourse do
	let!(:crash_course) { described_class.new(id: 1, title: "first course") }
	let(:subj) { CourseSubject.new(name: "Physics", id: 2) }

	describe ".add_subjects" do
		subject { crash_course.add_subjects(subj) }

		context "when there are existing subjects associated" do
			let(:subj_one) { CourseSubject.new(name: "Maths", id: 1) }

			before { crash_course.subjects << subj_one }

			let(:expected_outcome) { [subj_one, subj] }

			it { is_expected.to eql(expected_outcome) }
		end

		context "when there are no existing subjects associated" do
			it { is_expected.to eql([subj]) }
		end
	end

	describe ".filter_subjects" do
		subject { crash_course.filter_subjects(name: arg) }

		context "when no subject exists" do
			let(:arg) { 'test' }

			it { is_expected.to eql([]) }
		end

		context "when subject exists" do
			let(:arg) { subj.name }

			before { crash_course.subjects << subj }

			it { is_expected.to eql([subj]) }
		end
	end

	describe ".remove_subject" do
		subject { crash_course.remove_subject(id: arg) }

		let(:arg) { subj.id }

		context "when no subject are associated to the course" do
			it { is_expected.to eql([]) }			
		end

		context "when there are subjects assoicated" do
			let(:subj_one) { CourseSubject.new(name: "Maths", id: 1) }

			before { crash_course.subjects.push(subj, subj_one) }

			let(:arg) { subj.id }

			it { is_expected.to eql([subj_one]) }			
		end
	end
end
